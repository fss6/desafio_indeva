class CreateDailyGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_goals do |t|
      t.references :goal, foreign_key: true
      t.date :goal_date
      t.decimal :value
      t.json :seller_ids

      t.timestamps
    end
  end
end
