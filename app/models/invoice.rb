class Invoice < ApplicationRecord
  belong_to :customer
  belong_to :booking_ticket
end
