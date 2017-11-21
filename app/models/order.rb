class Order < ApplicationRecord
  belongs_to :customer
  validates :status, presence: true
  validates :customer_id, presence: true
  has_many :purchases
  has_many :products, through: :purchases
end
