class Api::SessionsController < ApplicationController
  def create
    customer_password = params[:session][:password]
    customer_email = params[:session][:email]
    customer = customer_email.present? && Customer.find_by(email: customer_email)

    if customer.valid_password? customer_password
      sign_in customer, store: false
      customer.generate_authentication_token!
      customer.save
      render json: customer, status: 200
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end
  
  def destroy
    customer = Customer.find_by(auth_token: params[:id])
    customer.generate_authentication_token!
    customer.save
    head 204
  end
end
