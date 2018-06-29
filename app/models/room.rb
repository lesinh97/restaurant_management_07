class Room < ApplicationRecord
  belongs_to :room_type
  has_many :booking_tickets, dependent: :delete_all
  scope :newest, ->{order(created_at: :desc)}
  scope :is_available, ->{where(available: true)}
end
