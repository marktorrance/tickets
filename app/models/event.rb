class Event < ActiveRecord::Base

  has_many :products
  scope :current, -> { where("end_date >= NOW()").order("end_date") }

end
