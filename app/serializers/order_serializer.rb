class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_many :products
end
