require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { city: @order.city, comments: @order.comments, delivery_time_requested: @order.delivery_time_requested, email: @order.email, event_id: @order.event_id, first_name: @order.first_name, last_name: @order.last_name, payment_auth: @order.payment_auth, phone1: @order.phone1, phone2: @order.phone2, products: @order.products, state: @order.state, street_address: @order.street_address, tax_cents: @order.tax_cents, total_cents: @order.total_cents, zip: @order.zip }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { city: @order.city, comments: @order.comments, delivery_time_requested: @order.delivery_time_requested, email: @order.email, event_id: @order.event_id, first_name: @order.first_name, last_name: @order.last_name, payment_auth: @order.payment_auth, phone1: @order.phone1, phone2: @order.phone2, products: @order.products, state: @order.state, street_address: @order.street_address, tax_cents: @order.tax_cents, total_cents: @order.total_cents, zip: @order.zip }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
