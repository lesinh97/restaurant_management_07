class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :country
      t.boolean :activated, default: false
      t.index  :email, unique: true
      t.timestamps
    end

  end
end
