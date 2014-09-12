class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :movie_image_url
      t.string :movie_trailer_url

      t.timestamps
    end
  end
end
