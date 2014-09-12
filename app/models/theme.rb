class Theme < ActiveRecord::Base
include CustomSlugs
		has_many :groks
		has_many :movies
		validates :keyword, 
			:presence => true, 
			:length => {:within => 4..25},
			:format => { with: /[\A-Za-z '-]+/, :message => "must be letters only."}
		validates_uniqueness_of :keyword, scope: :id, :message => "...try selecting a word from the dropdown instead of typing it out. It's sensitive."

	default_scope -> { order('themes.keyword ASC')}
	scope :search, lambda {|query| where(["keyword LIKE ?", "%query%"])}

	custom_slugs_with(:keyword)
 
 	before_save do self.keyword.titleize
 	end

	def keyword
	  read_attribute(:keyword).try(:titleize)
	end

	def self.today
		Theme.where("created_at >= ?", Time.zone.now.beginning_of_day)
	end

	def self.dedupe
		grouped = all.group_by { |theme| theme.keyword }
		grouped.values.each do |duplicates|
			first_one = duplicates.pop
			duplicates.each{|double| double.destroy}
		end
	end

	end
