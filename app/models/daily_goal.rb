class DailyGoal < ApplicationRecord
  belongs_to :goal, inverse_of: :daily_goals

  validates :goal_date, :value, presence: true

end
