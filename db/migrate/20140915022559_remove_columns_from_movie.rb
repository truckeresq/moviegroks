class RemoveColumnsFromMovie < ActiveRecord::Migration
  def up
    remove_column :movies, :genre
  end

  def down
    add_column :movies, :genre, :string
end
end
