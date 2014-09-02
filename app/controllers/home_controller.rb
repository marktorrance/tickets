class HomeController < ApplicationController
  def index
    @event = Event.current.first
    @order = Order.new
  end
  
  def ipn
    # Paypal notifying us of a completed payment
    
  end

end
