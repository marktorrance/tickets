require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { add_processing: @event.add_processing, check_payee: @event.check_payee, description: @event.description, email: @event.email, end_date: @event.end_date, name: @event.name, speak_to: @event.speak_to, start_date: @event.start_date, store_open: @event.store_open, thanks: @event.thanks }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { add_processing: @event.add_processing, check_payee: @event.check_payee, description: @event.description, email: @event.email, end_date: @event.end_date, name: @event.name, speak_to: @event.speak_to, start_date: @event.start_date, store_open: @event.store_open, thanks: @event.thanks }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
