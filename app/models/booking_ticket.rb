class BookingTicket < ApplicationRecord
  enum status: {cancel: 0, accetped: 1, waitting: 2, rejected: 3}
  belongs_to :customer
  has_many :invoices
  has_many :rooms
  scope :odering, ->{order(created_at: :desc)}
end
