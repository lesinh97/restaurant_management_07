class Room < ApplicationRecord
  belong_to :room_type
  has_many :booked_room
end
