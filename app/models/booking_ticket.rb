class BookingTicket < ApplicationRecord
  enum status: {cancel: 2, accetped: 1, waitting: 0}
  belongs_to :customer
  belongs_to :room
  has_many :invoices, dependent: :delete_all
  scope :newest, ->{order(created_at: :desc)}
end
