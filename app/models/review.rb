class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :room

  scope :newest, ->{order created_at: :desc}
  scope :review_by_room, ->room_id{where room_id: room_id}
end
