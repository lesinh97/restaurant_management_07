class AddStartAndEndDateToBookingTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :booking_tickets, :start_day, :datetime
    add_column :booking_tickets, :end_day, :datetime
  end
end
