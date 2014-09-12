class AddUserIdToGrok < ActiveRecord::Migration
  def change
    add_column :groks, :user_id, :integer
  end
end
