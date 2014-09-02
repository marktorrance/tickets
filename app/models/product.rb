class Product < ActiveRecord::Base

  belongs_to :event
  scope :enabled, -> { where("(enable_on is null OR enable_on <= NOW()) AND (disable_on is NULL or disable_on >= NOW())")}

end
