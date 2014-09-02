json.array!(@products) do |product|
  json.extract! product, :id, :event_id, :name, :short_name, :price_cents, :taxable, :enable_on, :disable_on, :default_quantity
  json.url product_url(product, format: :json)
end
