class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.references :store, foreign_key: true
      t.string :name
      t.date :start_date
      t.date :end_date
      t.decimal :total_value

      t.timestamps
    end
  end
end
