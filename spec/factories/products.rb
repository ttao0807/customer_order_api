FactoryGirl.define do
  factory :product do
    sequence(:name) {|n| "product#{n}" }
    price "9.99"
  end
end
