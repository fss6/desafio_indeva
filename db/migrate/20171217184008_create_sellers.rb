class CreateSellers < ActiveRecord::Migration[5.1]
  def change
    create_table :sellers do |t|
      t.string :registration
      t.string :name
      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
