class Product < ApplicationRecord
  validates :name, uniqueness: true
  has_many :purchases
  has_many :orders, through: :purchases
  has_many :inventories
  has_many :categories, through: :inventories
end
