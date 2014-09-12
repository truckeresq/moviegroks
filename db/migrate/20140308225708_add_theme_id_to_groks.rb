class AddThemeIdToGroks < ActiveRecord::Migration
  def change
    add_column :groks, :theme_id, :integer
  end
end
