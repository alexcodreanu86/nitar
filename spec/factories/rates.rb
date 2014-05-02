# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rate do |rate|
    rate.o_hare_price 65
    rate.midway_price 70
    rate.chicago_price 50
  end
end
