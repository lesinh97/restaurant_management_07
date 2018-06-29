class RoomType < ApplicationRecord
  has_many :rooms
  scope :odering, ->{order(created_at: :desc)}
end
