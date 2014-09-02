class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :event_id
      t.string :name
      t.string :short_name
      t.integer :price_cents
      t.boolean :taxable
      t.datetime :enable_on
      t.datetime :disable_on
      t.integer :default_quantity

      t.timestamps
    end
  end
end
