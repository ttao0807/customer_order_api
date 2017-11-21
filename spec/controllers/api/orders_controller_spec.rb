require 'rails_helper'

RSpec.describe Api::OrdersController, type: :controller do
  describe "GET #index" do
    before(:each) do
      current_customer = FactoryGirl.create :customer
      request.headers["Authorization"] = current_customer.auth_token
      4.times { FactoryGirl.create :order, customer: current_customer }
      get :index, params: {customer_id: current_customer.id}, format: :json
    end

    it "returns 4 order records from the user" do
      json_response = JSON.parse(response.body, symbolize_names: true)
      orders_response = json_response
      expect(orders_response.length).to eq(4)
    end

    it { should respond_with 200 }
  end
  
  describe "POST #create" do
    before(:each) do
      current_customer = FactoryGirl.create :customer
      request.headers["Authorization"] = current_customer.auth_token
      product_1 = FactoryGirl.create :product
      product_2 = FactoryGirl.create :product
      order_params = { status: "waiting for delivery", user_id: current_customer.id, product_ids: [product_1.id, product_2.id] }
      post :create, params: {customer_id: current_customer.id, order: order_params}, format: :json
    end

    it "returns the just customer order record" do
      json_response = JSON.parse(response.body, symbolize_names: true)
      order_response = json_response
      expect(order_response[:id]).to be_present
    end

    it { should respond_with 201 }
  end
end
