class AddAuthorshipToGrok < ActiveRecord::Migration
  def change
    add_column :groks, :authorship, :boolean
  end
end
