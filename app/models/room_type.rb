class RoomType < ApplicationRecord
  has_many :rooms, dependent: :delete_all
  scope :newest, ->{order(created_at: :desc)}
end
