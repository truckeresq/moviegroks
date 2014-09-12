class DeletePlaylist < ActiveRecord::Migration
 def up
  	drop_table :playlists
  end
end
