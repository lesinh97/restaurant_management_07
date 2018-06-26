class BookingTicket < ApplicationRecord
  enum status: {cancel: 0, accetped: 1, waitting: 2, rejected: 3}
  belongs_to :customer
  belongs_to :room
  has_many :invoices
  scope :odering, ->{order(created_at: :desc)}
end
