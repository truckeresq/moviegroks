class AddPitchToGroks < ActiveRecord::Migration
  def change
    add_column :groks, :pitch, :boolean
  end
end
