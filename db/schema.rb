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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110326212545) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.string   "recurrence"
    t.string   "admission"
    t.text     "description"
    t.integer  "facility_id"
  end

  create_table "facilities", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.string   "address"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

end
