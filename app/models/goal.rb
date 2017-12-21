class Goal < ApplicationRecord
  has_many :daily_goals, inverse_of: :goal, dependent: :destroy
  belongs_to :store
  accepts_nested_attributes_for :daily_goals

  validates :name, :store_id, :start_date, :end_date, :total_value, presence: true
  validate :end_date_great_than_start_date

  def goal_date
    @goal_date = DateTime.parse(@goal_date).strftime("%d/%m/%Y")
  end

  def end_date_great_than_start_date
    if end_date.present? && start_date.present? && end_date < start_date
      errors.add(:end_date, "não pode ser anterior a data de início")
    end
  end
end
