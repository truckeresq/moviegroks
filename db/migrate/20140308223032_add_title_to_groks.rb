class AddTitleToGroks < ActiveRecord::Migration
  def change
    add_column :groks, :title, :string
  end
end
