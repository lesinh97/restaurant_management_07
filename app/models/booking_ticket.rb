class BookingTicket < ApplicationRecord
  belongs_to :customer
  has_many :booked_rooms
  has_many :invoices
  scope :odering, ->{order(created_at: :desc)}
end
