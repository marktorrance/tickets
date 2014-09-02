class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  require "addressable/uri"

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        params = {
          cmd: "_cart",
          upload: "1",
          business: Rails.application.secrets.paypal_business_email,
          submit: "PayPal",
          first_name: @order.first_name,
          last_name: @order.last_name,
          address1: @order.address1,
          address2: @order.address2,
          city: @order.city,
          state: @order.state,
          zip: @order.zip,
          email: @order.email
        }
        products = JSON.parse(@order.products)
        products.each_with_index do |p,i0|
          i = i0 + 1
          params["item_name_#{i}".to_sym] = p['name']
          params["amount_#{i}".to_sym] = (p['price']/100.0).to_s
          params["quantity_#{i}".to_sym] = p['quantity'].to_s
          params["shipping_#{i}".to_sym] = "0.00"
        end

        format.html {
          uri = Addressable::URI.new
          uri.query_values = params
          redirect_to "https://www.paypal.com/cgi-bin/webscr?#{uri.query}"
          # render :html => params.inspect
        }
        # format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:event_id, :first_name, :last_name, :address1, :address2, :city, :state, :zip, :phone1, :phone2, :email, :payment_auth, :total_cents, :tax_cents, :products, :comments, :delivery_time_requested)
    end
end
