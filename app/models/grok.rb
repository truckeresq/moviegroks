class Grok < ActiveRecord::Base
		include CustomSlugs
		custom_slugs_with(:title)

		require 'open-uri'
		

		has_attached_file :audio,
					:storage => :s3,
					:bucket => ENV['bucket'],
					:path => ":attachment/:id/:basename.:extension",
					:url => 'https://#{bucket}.s3.amazonaws.com/'
					#:use_timestamp => false		

  		validates_presence_of :audio_remote_url, :if => :audio_remote_url_provided?, :message => 'is invalid or inaccessible'
		
		validates_attachment_size :audio, :less_than => 6.megabytes
		validates_attachment_content_type :audio, :content_type => ['audio/mpeg', 'audio/x-wav', 'audio/mp3', 'audio/wav']
						

		validates :title, presence: true, length: { maximum: 140}
		default_scope -> { order('created_at DESC')}
		belongs_to :user #foreign key - user_id
		# ensures that a user_id is present
		validates_presence_of :user

		belongs_to :book, inverse_of: :groks, autosave: true

		belongs_to :theme, inverse_of: :groks, autosave: true
		
		has_and_belongs_to_many :playlists
		
		accepts_nested_attributes_for :theme, :reject_if => :reject_attrs, :update_only => true, :allow_destroy => true
		accepts_nested_attributes_for :book, :reject_if => :reject_attrs, :update_only => true
		
		before_save validates_associated :theme, :book
		after_create :download_remote_audio
    	
    
		#after_create :show_final_errors

		def show_final_errors
			if audio.blank?
				self.errors.add(:base, "Forget to record your audio?")
				raise ActiveRecord::RecordInvalid.new(self)
			end
			true
		end

		acts_as_voteable

		def reject_attrs(attributed)
			lambda { |attrs| attrs.all? { |key, value| value.blank? }}
		end

		def theme_attributes
			theme.try(:keyword)
		end


		def theme_attributes=(keyword)
			self.theme = Theme.where(themes: keyword).first_or_create!
			rescue			
		end

		def book_attributes
			book.try(:title)
		end

		def book_attributes=(title)
			self.book = Book.find_or_create_by(title)
		end


		def before(job)
			self.processing = true
		end

		def download_remote_audio
				self.audio = do_download_remote_audio
				self.audio_remote_url = audio_remote_url
		    	self.save!
		    end	
		handle_asynchronously :download_remote_audio

  
  		def do_download_remote_audio
    	io = open(URI.parse(audio_remote_url))
    	def io.original_filename; base_uri.path.split('/').last; end
    	io.original_filename.blank? ? nil : io
  		rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  		end


  		def delete_temp_audio
      	s3 = AWS::S3.new(
         		:access_key_id => ENV['access_key_id'],
	 			:secret_access_key => ENV['secret_access_key']
       )
      		obj = s3.buckets['bookgroks.test/uploads'].objects[audio_file_name]
      		obj.delete 
      		puts obj
		end
		
		def after(job)
			grok = Grok.find_by_id(id)
			self.audio_remote_url = nil 
			self.processing = nil
			self.save!
		end

		scope :most_voted, -> do 
			 Grok.where(:created_at => 1.month.ago..Time.now).tally.where('vote = true').limit(10)
		end

		private
		  def audio_remote_url_provided?
		    !self.audio_remote_url.blank?
		  end

		end