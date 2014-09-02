json.array!(@orders) do |order|
  json.extract! order, :id, :event_id, :first_name, :last_name, :street_address, :city, :state, :zip, :phone1, :phone2, :email, :payment_auth, :total_cents, :tax_cents, :products, :comments, :delivery_time_requested
  json.url order_url(order, format: :json)
end
