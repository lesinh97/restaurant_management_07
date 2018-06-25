require "database_cleaner"

DatabaseCleaner.clean_with :truncation

10.times do |a|
  cus_name = Faker::DrWho.character
  phone_num = Faker::PhoneNumber.phone_number
  add = Faker::Address.street_name
  country = Faker::Address.country
  email = "mail-#{a+1}@mail.com"
  Customer.create!(name: cus_name, phone: phone_num, address: add, country: country,
    email: email, password: "hihihi", password_confirmation: "hihihi",
    activated: true)
end
10.times do |n|
  room_type  = Faker::DragonBall.unique.character
  bed_num = n+1
  descript = Faker::Dota.quote
  price = Faker::Commerce.price
  RoomType.create!(name:  room_type,
    bed_num: bed_num,
    description: descript,
    air_condition: true,
    price: price)
end
10.times do |m|
  room_numb = Faker::Military.dod_paygrade
  position = Faker::NewGirl.quote
  description = Faker::StrangerThings.quote
  room_type_id = m+1
  Room.create!(room_numb: room_numb,
    position: position,
    description: description,
    available: true,
    room_type_id: room_type_id)
end
10.times do |z|
  start_date = DateTime.now
  end_date =  Faker::Date.forward(z)
  numb_of_date = (end_date-start_date).to_i
  BookingTicket.create!(customer_id: z+1,
    success: true, start_day: start_date,
    end_day: end_date)
  BookedRoom.create!(room_id: z+1, booking_ticket_id: z+1,
    day_stay: numb_of_date)
end


