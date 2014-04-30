require 'csv'
@file = File.expand_path('../limo_rates.csv',__FILE__)
@csv_rates = File.open(@file)

@rates = CSV.parse(@csv_rates, :headers => true, :header_converters => :symbol)

@rates.each do |row|
  params = Hash(row)
  Rate.create(params)
end

HourlyRate.create(car_type: "Sedan", price_per_hour: 60)
HourlyRate.create(car_type: "Suv", price_per_hour: 85)
HourlyRate.create(car_type: "Luxury Sedan", price_per_hour: 100)

puts "Seeding completed"
