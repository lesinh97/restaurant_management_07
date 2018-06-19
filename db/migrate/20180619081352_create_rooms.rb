class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :room_numb
      t.string :position
      t.string :description
      t.boolean :available, default: true
      t.references :room_type, foreign_key: true
      t.timestamps
    end
  end
end
