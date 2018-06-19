class CreateStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :account
      t.datetime :join_at
      t.boolean :admin, default: false
      t.index :account, unique: true
      t.timestamps
    end
  end
end
