class CreateRoomTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :room_types do |t|
      t.string :name
      t.integer :bed_num
      t.boolean :air_condition
      t.string :description
      t.float :price
      t.timestamps
    end
  end
end
