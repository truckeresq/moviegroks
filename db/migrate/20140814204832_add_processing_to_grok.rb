class AddProcessingToGrok < ActiveRecord::Migration
  def self.up
    add_column :groks, :processing, :boolean
  end

  def self.down
  	remove_column :groks, :processing
  end
end
