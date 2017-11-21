class Api::OrdersController < ApplicationController
  respond_to :json

  def index
    @current_customer = Customer.find_by(auth_token: request.headers['Authorization'])
    respond_with @current_customer.orders
  end
  
  def create
    @current_customer = Customer.find_by(auth_token: request.headers['Authorization'])
    order = @current_customer.orders.build(order_params)
    order.date = Date.today
    order_params[:product_ids].each do |id|
      @product = Product.find(id);
      @product.categories.each do |category|
        @category = Category.find(category.id)
        @category.number_purchased = @category.number_purchased + 1
        @category.update
      end
    end
  
    if order.save
      render json: order, status: 201
    else
      render json: { errors: order.errors }, status: 422
    end
  end
  
  private
  
    def order_params
      params.require(:order).permit(:status, :customer_id, :product_ids => [])
    end
end
