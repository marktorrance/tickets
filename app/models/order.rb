class Order < ActiveRecord::Base
  scope :unconfirmed, -> { where(:payment_auth => nil) }

end
