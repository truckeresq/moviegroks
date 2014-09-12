class AddIndexToThemes < ActiveRecord::Migration
  def change
    add_index :themes, :keyword, unique: true
  end
end
