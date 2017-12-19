class StoreSeller < ApplicationRecord
  belongs_to :store
  belongs_to :seller
end
