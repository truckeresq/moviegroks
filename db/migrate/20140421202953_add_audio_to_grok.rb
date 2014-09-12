class AddAudioToGrok < ActiveRecord::Migration
  def self.up
    add_column :groks, :audio, :binary, limit: 5.megabytes
  end

  def self.down
  	remove_column :groks, :audio
end
end