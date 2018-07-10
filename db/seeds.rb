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
20.times do |m|
  room_numb = Faker::Military.unique.dod_paygrade
  position = Faker::NewGirl.quote
  description = Faker::StrangerThings.quote
  Room.create!(room_numb: room_numb,
    position: position,
    description: description,
    available: true,
    room_type_id: rand(9)+1)
end
9.times do |z|
  start_date = DateTime.now
  end_date =  Faker::Date.forward(z+1)
  numb_of_date = (end_date-start_date).to_i
  status = rand(2)
  room_id = 9-z
  booking_ticket_id = z+1
  room = Room.find(room_id)
  BookingTicket.create!(customer_id: z+1, room_id: room_id,
    start_day: start_date,
    end_day: end_date, status: status, stay_day_number: numb_of_date)
  room.update_attributes(available: false)
  booking_ticket = BookingTicket.find(booking_ticket_id)
  booking_ticket.update_attributes(total_price: booking_ticket.room.room_type.price * numb_of_date)
end
10.times do |j|
  customer_id = j+1
  cus = Customer.find(customer_id)
  total_booking = cus.booking_tickets.size
  cus.update_attributes(total_booking: total_booking)
end
9.times do |l|
  customer_id = l+1
  cus = Customer.find(customer_id)
  booking_ticket_id = cus.booking_tickets.ids[0]
  total = cus.booking_tickets.sum(:total_price)
  Invoice.create!(customer_id: customer_id, booking_ticket_id: booking_ticket_id, total: total)
end
9.times do |c|
  customer_id = c+1
  room_id = rand(19)
  content = Faker::Dota.quote
  Review.create!(customer_id: customer_id, room_id: room_id, content: content)
end
