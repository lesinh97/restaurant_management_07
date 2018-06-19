class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.references :staff, foreign_key: true
      t.references :booking_ticket, foreign_key: true
      t.float :total
      t.timestamps
    end
  end
end
