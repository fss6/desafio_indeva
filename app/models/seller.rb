class Seller < ApplicationRecord
  belongs_to :owner
  has_one :store_seller, dependent: :restrict_with_error
  has_one :store, through: :store_seller

  validates :registration, :name, :owner, presence: true
  validates :registration, uniqueness: true
  validates :registration, numericality: { only_integer: true }


  def show_name
    "#{name} - Matricula: #{registration}"
  end

end
