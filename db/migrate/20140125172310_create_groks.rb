class CreateGroks < ActiveRecord::Migration
  def change
    create_table :groks do |t|
    
			# http://stackoverflow.com/questions/17139750/ruby-on-rails-true-button-to-boolean-datatype-in-database
      t.timestamps
    	end
	end
end
