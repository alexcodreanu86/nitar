class Trip < ActiveRecord::Base
  belongs_to :car
  belongs_to :user
  belongs_to :rate
  has_many :extra_charges, dependent: :destroy

  validates :trip_type, :car_id, :number_of_passengers, :pickup_time, :pick_up, :drop_off, :contact_name, :contact_phone, :contact_email, presence: true

  after_create :check_for_extras

  def check_for_extras
    if (1..3).cover? self.trip_type.to_i     
      self.extra_charges.create(description: "MPEA Airport Tax", price: 4)
      self.extra_charges.create(description: "Airport Greet(Domestic)", price: 24) if self.trip_type.to_i == 2
      self.extra_charges.create(description: "Airport Greet(International)", price: 40) if self.trip_type.to_i == 3
    else
      assign_total_price
    end
  end

  def assign_total_price
    extras = self.extra_charges.map(&:price).inject(&:+) 
    self.total_price = self.base_price + (extras ? extras : 0) 
    self.save
  end
end
