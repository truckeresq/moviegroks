class AddAudioRemoteUrlToGrok < ActiveRecord::Migration
  def self.up
    add_column :groks, :audio_remote_url, :string
  end

  def self.down
  	remove_column :groks, :audio_remote_url
	end

end