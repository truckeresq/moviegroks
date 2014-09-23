class Movie < ActiveRecord::Base
		has_and_belongs_to_many :blogs
		has_many :groks
		has_many :themes
		validates :title, :presence => true, :uniqueness => true, on: :create
include CustomSlugs
custom_slugs_with(:title)

default_scope -> { order('movies.title ASC')}
end
