require "database_cleaner"

DatabaseCleaner.clean_with :truncation

10.times do |a|
  cus_name = Faker::DrWho.character
  phone_num = Faker::PhoneNumber.phone_number
  add = Faker::Address.street_name
  country = Faker::Address.country
  email = "mail-#{a+1}@mail.com"
  role = rand(2)
  Customer.create!(name: cus_name, phone: phone_num, address: add, country: country,
    email: email, password: "hihihi", password_confirmation: "hihihi",
    activated: true, role: role)
end
10.times do |n|
  room_type  = Faker::DragonBall.unique.character
  bed_num = n+1
  descript = Faker::Dota.quote
  price = Faker::Commerce.price
  RoomType.create!(name: room_type,
    bed_num: bed_num,
    description: descript,
    air_condition: true,
    price: price)
end
10.times do |m|
  room_numb = Faker::Military.dod_paygrade
  position = Faker::NewGirl.quote
  description = Faker::StrangerThings.quote
  Room.create!(room_numb: room_numb,
    position: position,
    description: description,
    available: true,
    room_type_id: m+1)
end
10.times do |z|
  start_date = DateTime.now
  end_date =  Faker::Date.forward(z)
  numb_of_date = (end_date-start_date).to_i
  status = rand(4)
  BookingTicket.create!(customer_id: z+1, room_id: 10-z,
    start_day: start_date,
    end_day: end_date, status: status, stay_day_number: numb_of_date)
end
