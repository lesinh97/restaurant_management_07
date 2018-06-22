# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
