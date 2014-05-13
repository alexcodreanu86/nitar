require 'csv'
@file = File.expand_path('../limo_rates.csv',__FILE__)
@csv_rates = File.open(@file)

@rates = CSV.parse(@csv_rates, :headers => true, :header_converters => :symbol)

@rates.each do |row|
  params = Hash(row)
  Rate.create(params)
end

Car.create(name: "Sedan", price_ratio: 1, hourly_rate: 55, capacity: 3)
Car.create(name: "Private Suv", price_ratio: 1.2, hourly_rate: 75, capacity: 6)
Car.create(name: "Luxury Black Car", price_ratio: 1.3, hourly_rate: 85, capacity: 3)
User.create(name: "Alex Codreanu", email: "test@test.com", password: "testtest", password_confirmation: "testtest", phone: "1231231234", is_admin: true)
puts "Seeding completed"
