class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :room_id
      t.integer :customer_id
      t.text :content

      t.timestamps
    end
    add_index :reviews, :customer_id
    add_index :reviews, :room_id
  end
end
