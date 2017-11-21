require 'rails_helper'

RSpec.describe Purchase, type: :model do
  let(:purchase) { FactoryGirl.build :purchase }
  subject { purchase }

  it { should respond_to :order_id }
  it { should respond_to :product_id }

  it { should belong_to :order }
  it { should belong_to :product }
end
