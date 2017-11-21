class Category < ApplicationRecord
  validates :name, uniqueness: true
  has_many :inventories
  has_many :products, through: :inventories
end
