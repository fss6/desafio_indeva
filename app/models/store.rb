class Store < ApplicationRecord
  belongs_to :owner
  has_many :store_sellers, dependent: :restrict_with_error
  has_many :sellers, through: :store_sellers
  # accepts_nested_attributes_for :store_sellers

  validates :name, :owner_id, :sellers, presence: true

  def get_available_sellers
    Seller.joins("LEFT JOIN store_sellers ON sellers.id = store_sellers.seller_id")
    .where('store_sellers.store_id = ? OR store_sellers.store_id IS NULL', self.id)
    .collect{|obj| [ obj.show_name, obj.id ]}
  end
end
