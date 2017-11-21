class Purchase < ApplicationRecord
  belongs_to :order, inverse_of: :purchases
  belongs_to :product, inverse_of: :purchases
end
