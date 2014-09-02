class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.string :check_payee
      t.string :email
      t.text :speak_to
      t.text :thanks
      t.string :store_open
      t.string :add_processing

      t.timestamps
    end
  end
end
