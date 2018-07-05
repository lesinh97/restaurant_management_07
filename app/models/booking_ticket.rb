class BookingTicket < ApplicationRecord
  enum status: {cancel: 2, accetped: 1, waitting: 0}
  belongs_to :customer
  belongs_to :room
  has_many :invoices, dependent: :delete_all
  validates :start_day, presence: true
  validates :end_day, presence: true
  validate :check_overlapping
  scope :newest, ->{order(created_at: :desc)}

  def check_overlapping
    return if start_day.nil? && end_day.nil?
    errors.add :start_day if start_day >= end_day
  end
end
