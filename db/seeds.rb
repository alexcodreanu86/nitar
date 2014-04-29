require 'csv'
@file = File.expand_path('../limo_rates.csv',__FILE__)
@csv_rates = File.open(@file)

@rates = CSV.parse(@csv_rates, :headers => true, :header_converters => :symbol)

@rates.each do |row|
  params = Hash(row)
  Rate.create(params)
end

puts "Seeding completed"
