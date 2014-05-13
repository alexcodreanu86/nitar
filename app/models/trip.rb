class Trip < ActiveRecord::Base
  belongs_to :car
  belongs_to :user
  belongs_to :rate

  validates :trip_type, :car_id, :number_of_passengers, :pickup_time, presence: true
end
