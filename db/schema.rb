# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_23_020757) do

  create_table "pharmacist_profiles", force: :cascade do |t|
    t.string "name", null: false
    t.string "image"
    t.string "work_place", null: false
    t.integer "work_place_type", null: false
    t.integer "work_location", default: 0, null: false
    t.string "university", null: false
    t.text "introduction", null: false
    t.integer "pharmacist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pharmacist_id"], name: "index_pharmacist_profiles_on_pharmacist_id", unique: true
  end

  create_table "pharmacists", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_pharmacists_on_email", unique: true
    t.index ["reset_password_token"], name: "index_pharmacists_on_reset_password_token", unique: true
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "pharmacist_id", null: false
    t.integer "student_id", null: false
    t.boolean "allow", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pharmacist_id", "student_id"], name: "index_relationships_on_pharmacist_id_and_student_id", unique: true
    t.index ["pharmacist_id"], name: "index_relationships_on_pharmacist_id"
    t.index ["student_id"], name: "index_relationships_on_student_id"
  end

  create_table "student_profiles", force: :cascade do |t|
    t.string "name", null: false
    t.string "image"
    t.string "university", null: false
    t.integer "year", null: false
    t.text "introduction", null: false
    t.integer "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_student_profiles_on_student_id", unique: true
  end

  create_table "students", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  add_foreign_key "pharmacist_profiles", "pharmacists"
  add_foreign_key "relationships", "pharmacists"
  add_foreign_key "relationships", "students"
  add_foreign_key "student_profiles", "students"
end
