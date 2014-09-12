class DeleteFavoriteQuote < ActiveRecord::Migration
  def up
  	drop_table :favorite_quotes
  end
end
