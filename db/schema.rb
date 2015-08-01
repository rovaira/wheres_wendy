ActiveRecord::Schema.define(version: 20150722172350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "current_locations", force: :cascade do |t|
    t.integer "user_id",   null: false
    t.string  "address"
    t.float   "latitude"
    t.float   "longitude"
  end

  add_index "current_locations", ["user_id"], name: "index_current_locations_on_user_id", unique: true, using: :btree

  create_table "pings", force: :cascade do |t|
    t.integer  "sender_id",   null: false
    t.integer  "receiver_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.integer  "class_year",                             null: false
    t.string   "blurb"
    t.string   "phone"
    t.boolean  "share_phone",            default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
