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

  describe "POST #create" do

    context "when customer successfully created" do
      before(:each) do
        @customer_attributes = FactoryGirl.attributes_for :customer
        post :create, params: {customer: @customer_attributes }, format: :json
      end

      it "renders the json representation for the customer record created" do
        customer_response = JSON.parse(response.body, symbolize_names: true)
        expect(customer_response[:email]).to eql @customer_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when customer is not created" do
      before(:each) do
        @invalid_customer_attributes = { password: "pwd", password_confirmation: "pwd" }
        post :create, params: { customer: @invalid_customer_attributes }, format: :json
      end

      it "renders an errors json" do
        customer_response = JSON.parse(response.body, symbolize_names: true)
        expect(customer_response).to have_key(:errors)
      end

      it "renders the json errors on why the customer could not be created" do
        customer_response = JSON.parse(response.body, symbolize_names: true)
        expect(customer_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  
  describe "PUT/PATCH #update" do

    context "when is successfully updated" do
      before(:each) do
        @customer = FactoryGirl.create :customer
        patch :update, params: { id: @customer.id, customer: { email: "newcustomer@example.com" } }, format: :json
      end

      it "renders the json representation for the updated customer" do
        customer_response = JSON.parse(response.body, symbolize_names: true)
        expect(customer_response[:email]).to eql "newcustomer@example.com"
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        @customer = FactoryGirl.create :customer
        patch :update, params: { id: @customer.id, customer: { email: "bademailaddress" } }, format: :json
      end

      it "renders an errors json" do
        customer_response = JSON.parse(response.body, symbolize_names: true)
        expect(customer_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        customer_response = JSON.parse(response.body, symbolize_names: true)
        expect(customer_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end
  end
  
  describe "DELETE #destroy" do
    before(:each) do
      @customer = FactoryGirl.create :customer
      delete :destroy, params: { id: @customer.id }, format: :json
    end

    it { should respond_with 204 }

  end
end
