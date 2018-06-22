class Room < ApplicationRecord
  belongs_to :room_type
  has_many :booked_room
  scope :odering, ->{order(created_at: :desc)}
end
