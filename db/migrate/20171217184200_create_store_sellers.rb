class CreateStoreSellers < ActiveRecord::Migration[5.1]
  def change
    create_table :store_sellers, id: false do |t|
      t.references :store, foreign_key: true
      t.references :seller, foreign_key: true

      t.timestamps
    end
  end
end
