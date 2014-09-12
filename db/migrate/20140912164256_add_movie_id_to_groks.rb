class AddMovieIdToGroks < ActiveRecord::Migration
  def change
    add_column :groks, :movie_id, :integer
  end
end
