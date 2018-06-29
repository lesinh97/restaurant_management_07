class AddPaymentToBookingTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :booking_tickets, :total_price, :float
  end
end
