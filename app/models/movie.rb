class Movie < ActiveRecord::Base
		has_many :groks
		has_many :themes
		validates :title, :presence => true, :uniqueness => true
include CustomSlugs
custom_slugs_with(:title)

default_scope -> { order('movies.title ASC')}
end
