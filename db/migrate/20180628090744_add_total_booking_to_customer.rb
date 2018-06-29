class AddTotalBookingToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :total_booking, :integer
  end
end
