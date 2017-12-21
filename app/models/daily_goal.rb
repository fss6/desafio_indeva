class DailyGoal < ApplicationRecord
  belongs_to :goal, inverse_of: :daily_goals
  validates :goal_date, :value, presence: true

  def sellers
    Seller.select('sellers.*')
      .where('sellers.id IN (?)', self.seller_ids)
  end
end
