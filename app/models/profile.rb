class Profile < ActiveRecord::Base
	belongs_to :user, :inverse_of => :profile
	# validates :website, format: { with: URI::regexp(%w(http https)), message: "Please enter a valid web address." } 


def location
	[city, state].reject(&:blank?).join(", ")
end

end