class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :event_id
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone1
      t.string :phone2
      t.string :email
      t.string :payment_auth
      t.integer :total_cents
      t.integer :tax_cents
      t.text :products
      t.text :comments
      t.string :delivery_time_requested

      t.timestamps
    end
  end
end
