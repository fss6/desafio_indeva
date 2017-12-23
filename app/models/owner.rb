class Owner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stores
  has_many :sellers
  validates :name, presence: true

  def goals
    Goal.joins(:store).where(stores: { owner_id: self.id})
  end
end
