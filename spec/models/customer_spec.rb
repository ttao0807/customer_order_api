require 'rails_helper'

RSpec.describe Customer, type: :model do
  before { @customer = FactoryGirl.build(:customer) }
 
  subject { @customer }
 
  it { should validate_presence_of(:email) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should validate_presence_of(:password) }
  it { should validate_confirmation_of(:password) }
end
