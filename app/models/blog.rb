class Blog < ActiveRecord::Base
	has_and_belongs_to_many :movies
	accepts_nested_attributes_for :movies, :reject_if => :reject_attrs

	def reject_attrs(attributed)
		lambda { |attrs| attrs.all? { |key, value| value.blank? }}
	end

	validates :post, :presence => true
	default_scope -> { order('blogs.created_at DESC')}
end
