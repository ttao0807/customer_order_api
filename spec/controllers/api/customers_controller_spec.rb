require 'rails_helper'

RSpec.describe Api::CustomersController, type: :controller do
  describe "GET #show" do
    before(:each) do
      @customer = FactoryGirl.create :customer
      get :show, params: {id: @customer.id}, format: :json
    end

    it "returns the response with email address" do
      customer_response = JSON.parse(response.body, symbolize_names: true)
      expect(customer_response[:email]).to eql @customer.email
    end

    it { should respond_with 200 }
  end

end
