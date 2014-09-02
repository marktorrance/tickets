json.array!(@events) do |event|
  json.extract! event, :id, :name, :description, :start_date, :end_date, :check_payee, :email, :speak_to, :thanks, :store_open, :add_processing
  json.url event_url(event, format: :json)
end
