FactoryGirl.define do
  factory :customer do
    email { FFaker::Internet.email }
    first_name "Tao"
    last_name "Tao"
    password "password"
    password_confirmation "password"
  end
end
