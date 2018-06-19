class BookedRoom < ApplicationRecord
  belong_to :room
  belong_to :booking_ticket
end
