# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20140208112245) do

  create_table "admin_users", :force => true do |t|
    t.string   "name"
    t.string   "real_name"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.spatial  "area",         :limit => {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.integer  "left"
    t.integer  "right"
    t.integer  "parent_left"
    t.integer  "parent_right"
    t.datetime "created_at",                                                                  :null => false
    t.datetime "updated_at",                                                                  :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "real_name"
    t.string   "password_digest"
    t.spatial  "location",        :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime "created_at",                                                                  :null => false
    t.datetime "updated_at",                                                                  :null => false
  end

end
