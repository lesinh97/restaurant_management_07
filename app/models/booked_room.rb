class BookedRoom < ApplicationRecord
  belongs_to :room
  belongs_to :booking_ticket
end
