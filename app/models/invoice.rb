class Invoice < ApplicationRecord
  belong_to :staff
  belong_to :booking_ticket
end
