class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :booking_ticket
  scope :newest, ->{order(created_at: :desc)}
end
