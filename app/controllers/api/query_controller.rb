class Api::QueryController < ApplicationController
  respond_to :json

  def list
    @query = Array.new
    @customers = Customer.order(:id)
    @customers.each do |c|
      @categories = Array.new
      @orders = c.orders
      @orders.each do |o|
        @products = o.products
        @products.each do |p|
          @product_categories = p.categories
          @product_categories.each do |category|
            unless @categories.include?(category)
              @categories.push(category)
            end
          end
        end
      end
      @categories.each do |category|
        @query.push({customer_id: c.id, customer_first_name: c.first_name, category_id: category.id, category_name: category.name, number_purchased: category.number_purchased})
      end
    end

    respond_with @query
  end
  
  #suppose JSON request consists of start_date, end_date and period between day/week/month
  #return decimal value of 1 digit precision
  def calculate
    @calc = Hash.new
    @orders = Order.where("date >= ? and date <= ?", params[:start_date], params[:end_date])
    @products = Array.new
    @orders.each do |o|
      @products = o.products
      @products.each do |product|
        unless @calc.has_key?(product.name)
          @calc[product.name] = 0
        end
        @calc[product.name] = @calc[product.name] + 1
      end
    end
    
    @numOfDays = (Date.parse(params[:end_date]) - Date.parse(params[:start_date]) + 1).to_i
    @query = Hash.new

    if params[:period] == "day"
      @calc.each do |k, v|
        @query[k] = (v.to_f / @numOfDays).round(1)
      end
    end
    
    if params[:period] == "week"
      @calc.each_value do |k, v|
        @query[k] = ((v * 7).to_f / @numOfDays).round(1)
      end
    end
    
    if params[:period] == "week"
      @calc.each_value do |k, v|
        @query[k] = ((v * 30).to_f / @numOfDays).round(1)
      end
    end
    
      respond_with @query
  end
end
