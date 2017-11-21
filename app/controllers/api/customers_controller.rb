class Api::CustomersController < ApplicationController
  respond_to :json

  def show
    respond_with Customer.find(params[:id])
  end
  
  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: customer, status: 201
    else
      render json: { errors: customer.errors }, status: 422
    end
  end

  def update
    customer = Customer.find(params[:id]) 
    if customer.update(customer_params)
      render json: customer, status: 200
    else
      render json: { errors: customer.errors }, status: 422
    end
  end
  
  def destroy
    customer = Customer.find(params[:id])
    customer.destroy
    head 204
  end
  
  private

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
