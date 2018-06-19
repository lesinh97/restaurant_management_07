class CreateBookingTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :booking_tickets do |t|
      t.references :customer, foreign_key: true
      t.datetime :booking_date
      t.boolean :success
      t.timestamps
    end
  end
end
