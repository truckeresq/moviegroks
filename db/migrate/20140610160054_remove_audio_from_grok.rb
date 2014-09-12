class RemoveAudioFromGrok < ActiveRecord::Migration
  def up
    remove_column :groks, :audio
  end

  def down
  	add_column  :groks, :audio, :binary
end

end