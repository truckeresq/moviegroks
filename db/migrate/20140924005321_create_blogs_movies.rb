class CreateBlogsMovies < ActiveRecord::Migration
  def self.up
    create_table :blogs_movies, :id => false do |t|
    	t.integer :blog_id
    	t.integer :movie_id
    end
    add_index :blogs_movies, [:blog_id, :movie_id]
  end

  def self.down
  	drop_table :blogs_movies
end
end
