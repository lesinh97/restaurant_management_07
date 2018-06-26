class CreateBookingTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :booking_tickets do |t|
      t.references :customer, foreign_key: true
      t.references :room, foreign_key: true
      t.datetime :start_day
      t.datetime :end_day
      t.integer :stay_day_number
      t.integer :status, default: 1
      t.timestamps
    end
  end
end
