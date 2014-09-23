class RemoveMovieIdFromBlog < ActiveRecord::Migration
  def change
    remove_column :blogs, :movie_id, :integer
  end
end
