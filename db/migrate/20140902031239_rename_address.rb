class RenameAddress < ActiveRecord::Migration
  def change
    rename_column :orders, :street_address, :address1
  end
end
