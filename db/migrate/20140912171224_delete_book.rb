class DeleteBook < ActiveRecord::Migration
  def up
  	drop_table :books
  end
end
