class CreateBookedRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :booked_rooms do |t|
      t.references :room, foreign_key: true
      t.references :booking_ticket, foreign_key: true
      t.integer :day_stay
      t.timestamps
    end
  end
end
