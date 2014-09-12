class AddAttachmentAudioToGroks < ActiveRecord::Migration
  def change
    add_attachment :groks, :audio
    end
end
