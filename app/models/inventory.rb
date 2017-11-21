class Inventory < ApplicationRecord
  belongs_to :category, inverse_of: :inventories
  belongs_to :product, inverse_of: :inventories
end
