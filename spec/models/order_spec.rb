require 'rails_helper'

RSpec.describe Order do
  let(:order) { FactoryGirl.build :order }
  subject { order }

  it { should respond_to(:status) }
  it { should respond_to(:customer_id) }

  it { should validate_presence_of :customer_id }
  it { should validate_presence_of :status}

  it { should belong_to :customer }
  it { should have_many(:purchases) }
  it { should have_many(:products).through(:purchases) }
end
