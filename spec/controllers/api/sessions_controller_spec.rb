require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  
  describe "POST #create" do

   before(:each) do
    @customer = FactoryGirl.create :customer
   end

    context "when the credentials are correct" do

      before(:each) do
        credentials = { email: @customer.email, password: @customer.password }
        post :create, params: { session: credentials }, format: :json
      end

      it "returns the user record corresponding to the given credentials" do
        @customer.reload
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:auth_token]).to eql @customer.auth_token
      end

      it { should respond_with 200 }
    end

    context "when the credentials are incorrect" do

      before(:each) do
        credentials = { email: @customer.email, password: "invalidpassword" }
        post :create, params: { session: credentials },  format: :json
      end

      it "returns a json with an error" do
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:errors]).to eql "Invalid email or password"
      end

      it { should respond_with 422 }
    end
  end
  
  describe "DELETE #destroy" do

    before(:each) do
      @customer = FactoryGirl.create :customer
      delete :destroy, params:{ id: @customer.auth_token }, format: :json
    end

    it { should respond_with 204 }

  end

end
