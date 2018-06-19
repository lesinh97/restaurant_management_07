class BookingTicket < ApplicationRecord
  belong_to :customer
  has_many :booked_rooms
  has_many :invoices
end
