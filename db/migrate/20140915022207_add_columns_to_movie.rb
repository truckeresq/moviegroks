class AddColumnsToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :genre, :string
    add_column :movies, :summary, :text
  end
end
