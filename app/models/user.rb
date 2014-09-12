class User < ActiveRecord::Base

include CustomSlugs

  has_secure_password

		validates :first_name, :presence => true, :length => { :maximum => 25 }
		validates :last_name, :presence => true, :length => { :maximum => 50 }
		validates :password, :length => { :within => 7..20, on: :create }, :confirmation => true
		validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }, :uniqueness => true

		has_one	 :profile, :inverse_of => :user, :dependent => :destroy
		accepts_nested_attributes_for :profile, update_only: true
		has_many :groks, :dependent => :delete_all
		has_many :playlists, dependent: :destroy
		has_many :likes, through: :groks

		before_create { generate_token(:auth_token) }
		after_create :build_profile
		
		def build_profile
			Profile.create(user: self)
		end

		acts_as_voter

  		def favs
    		Grok.where(:id => self.votes.where(:voteable_type => 'Grok').map(&:voteable_id))
    	end
 
		def send_reset_password
			generate_token(:reset_password_token)
			self.reset_password_sent_at = Time.zone.now
			save!
			UserMailer.reset_password(self).deliver
		end
		
		def generate_token(column)
			begin
				self[column] = SecureRandom.urlsafe_base64
			end while User.exists?(column => self[column])
		end

		def display_name
			"#{first_name} #{last_name}"
		end

		def name
			self.first_name + '' + self.last_name
		end

		default_scope -> { order('users.first_name ASC')}
		
		custom_slugs_with(:name)


end
