FactoryGirl.define do
  factory :order do
    customer nil
    status "Waiting for delivery"
  end
end
