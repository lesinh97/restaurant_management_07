# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180620060713) do

  create_table "booking_tickets", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "room_id"
    t.datetime "start_day"
    t.datetime "end_day"
    t.integer "stay_day_number"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_booking_tickets_on_customer_id"
    t.index ["room_id"], name: "index_booking_tickets_on_room_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "country"
    t.boolean "activated", default: false
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_customers_on_email", unique: true
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "booking_ticket_id"
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_ticket_id"], name: "index_invoices_on_booking_ticket_id"
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
  end

  create_table "room_types", force: :cascade do |t|
    t.string "name"
    t.integer "bed_num"
    t.boolean "air_condition"
    t.string "description"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "room_numb"
    t.string "position"
    t.string "description"
    t.boolean "available", default: true
    t.integer "room_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_type_id"], name: "index_rooms_on_room_type_id"
  end

end
