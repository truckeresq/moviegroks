class CreateFavoriteQuotes < ActiveRecord::Migration
  def change
    create_table :favorite_quotes do |t|
      t.text :quote
      t.string :movie
      t.string :year

      t.timestamps
    end
  end
end
