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

ActiveRecord::Schema.define(version: 2019_12_04_081012) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "prefecture_id", null: false
    t.string "city", null: false
    t.string "family_name", null: false
    t.string "last_name", null: false
    t.string "postal_code", null: false
    t.string "banti", null: false
    t.string "building_name", null: false
    t.string "phone_number", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "deliveries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "derivery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estimateds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "estimated_shipping_date_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "image", null: false
    t.integer "size"
    t.integer "state", null: false
    t.integer "delivery_fee", null: false
    t.integer "shipping_method", null: false
    t.integer "estimated_shipping_date", null: false
    t.integer "price", null: false
    t.text "text", null: false
    t.integer "inappropriate_item"
    t.integer "prefecture_id"
    t.integer "state_id"
    t.integer "delivery_id"
    t.integer "estimated_shipping_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pays", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "card_number", null: false
    t.integer "deadline_month_id", null: false
    t.integer "deadline_year_id", null: false
    t.integer "security_code", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pays_on_user_id"
  end

  create_table "sns_credentials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sns_credentials_on_user_id"
  end

  create_table "states", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname", null: false
    t.string "introduction"
    t.string "family_name", null: false
    t.string "last_name", null: false
    t.string "j_family_name", null: false
    t.string "j_last_name", null: false
    t.integer "birthday_year_id", null: false
    t.integer "birthday_month_id", null: false
    t.integer "birthday_day_id", null: false
    t.string "phone_number", null: false
    t.text "image"
    t.integer "point"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "pays", "users"
  add_foreign_key "sns_credentials", "users"
end
