class AddColumnToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :keyword, :text
  end
end
