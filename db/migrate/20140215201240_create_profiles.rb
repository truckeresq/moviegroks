class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :city
      t.string :state
      t.string :website
      t.integer :user_id

      t.timestamps
    end
  end
end
