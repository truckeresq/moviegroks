class RemoveBookIdFromGroks < ActiveRecord::Migration
  def change
    remove_column :groks, :book_id, :integer
  end
end
