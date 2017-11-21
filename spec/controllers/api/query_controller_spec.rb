require 'rails_helper'

RSpec.describe Api::QueryController, type: :controller do

  describe "GET #list" do
    before(:each) do
      current_customer = FactoryGirl.create :customer
      product_1 = FactoryGirl.create :product
      product_2 = FactoryGirl.create :product
      category_1 = FactoryGirl.create :category
      inventory_1 = FactoryGirl.create :inventory, product_id: product_1.id, category_id: category_1.id
      inventory_2 = FactoryGirl.create :inventory, product_id: product_2.id, category_id: category_1.id
      product_3 = FactoryGirl.create :product
      category_2 = FactoryGirl.create :category
      category_3 = FactoryGirl.create :category
      inventory_3 = FactoryGirl.create :inventory, product_id: product_3.id, category_id: category_2.id
      inventory_4 = FactoryGirl.create :inventory, product_id: product_3.id, category_id: category_3.id
      order_1 = FactoryGirl.create :order, customer_id:current_customer.id, product_ids: [product_1.id, product_2.id]
      order_2 = FactoryGirl.create :order, customer_id:current_customer.id, product_ids: [product_3.id]
    end
    
    # order_1 come with 2 products in 1 category
    # order_2 come with 1 product in 2 category
    # so should get 3 categories in total
    it "returns list of caterory purchased" do
      get :list, format: :json
      json_response = JSON.parse(response.body, symbolize_names: true)
      order_response = json_response
      expect(json_response.length).to equal(3)
    end
  end

  describe "GET #calculate" do
    
    it "returns product sold per day" do
      current_customer = FactoryGirl.create :customer
      product_1 = FactoryGirl.create :product, name: "product_1"
      product_2 = FactoryGirl.create :product, name: "product_2"
      product_3 = FactoryGirl.create :product, name: "product_3"
      order_1 = FactoryGirl.create :order, customer_id:current_customer.id, product_ids: [product_1.id, product_2.id], date: Date.today
      order_2 = FactoryGirl.create :order, customer_id:current_customer.id, product_ids: [product_2.id, product_3.id], date: Date.tomorrow
      get :calculate, params:{start_date: Date.today, end_date: Date.tomorrow, period: "day" }, format: :json
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:product_1]).to equal(0.5)
      expect(json_response[:product_2]).to equal(1.0)
      expect(json_response[:product_3]).to equal(0.5)
    end
  end
end
