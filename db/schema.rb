# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_14_193429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "licenses", force: :cascade do |t|
    t.integer "cnh_type", null: false
    t.string "cnh_number", null: false
    t.date "first_cnh_date", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_licenses_on_user_id"
  end

  create_table "news", force: :cascade do |t|
    t.string "content"
    t.date "date"
    t.string "link"
    t.string "log_error"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "cpf", null: false
    t.date "birth_date", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate", null: false
    t.string "chassi", null: false
    t.string "renavam", null: false
    t.bigint "user_id"
    t.index ["chassi"], name: "index_vehicles_on_chassi", unique: true
    t.index ["plate"], name: "index_vehicles_on_plate", unique: true
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

end
