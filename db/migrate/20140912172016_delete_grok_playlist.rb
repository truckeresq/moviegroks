class DeleteGrokPlaylist < ActiveRecord::Migration
  def up
  	drop_table :groks_playlists
  end
end
