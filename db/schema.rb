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

ActiveRecord::Schema.define(version: 20160712051857) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "distributors", force: :cascade do |t|
    t.string   "provider",                           default: "email", null: false
    t.string   "uid",                                default: "",      null: false
    t.string   "encrypted_password",                 default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "distributor_code",                                     null: false
    t.integer  "distributor_referror_id"
    t.string   "first_name",                                           null: false
    t.string   "middle_name"
    t.string   "last_name",                                            null: false
    t.date     "date_of_birth"
    t.string   "nickname",                limit: 40
    t.string   "citizens_id",                                          null: false
    t.string   "email"
    t.text     "address"
    t.string   "district"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "telephone_number"
    t.string   "mobile_number"
    t.string   "active",                             default: "t",     null: false
    t.json     "tokens"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "staff_creator_id"
    t.index ["distributor_code"], name: "index_distributors_on_distributor_code", unique: true, using: :btree
    t.index ["email"], name: "index_distributors_on_email", unique: true, using: :btree
    t.index ["id", "distributor_referror_id"], name: "index_distributor_sponsor", unique: true, using: :btree
    t.index ["id", "staff_creator_id"], name: "index_distributor_staff_creator", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_distributors_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_distributors_on_uid_and_provider", unique: true, using: :btree
  end

  create_table "staffs", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "employee_code",                            null: false
    t.string   "first_name",                               null: false
    t.string   "last_name",                                null: false
    t.string   "nickname"
    t.string   "email"
    t.string   "staff_account",                            null: false
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["email"], name: "index_staffs_on_email", unique: true, using: :btree
    t.index ["employee_code"], name: "index_staffs_on_employee_code", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true, using: :btree
    t.index ["staff_account"], name: "index_staffs_on_staff_account", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_staffs_on_uid_and_provider", unique: true, using: :btree
  end

  create_table "supplier_contact_infos", force: :cascade do |t|
    t.string   "contact_person"
    t.string   "telephone_number"
    t.string   "telephone_ext"
    t.string   "mobile_number"
    t.string   "fax_number"
    t.string   "fax_ext"
    t.integer  "supplier_supplier_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["supplier_supplier_id"], name: "index_supplier_contact_infos_on_supplier_supplier_id", using: :btree
  end

  create_table "supplier_suppliers", force: :cascade do |t|
    t.string   "company_code"
    t.string   "display_name"
    t.string   "tax_id"
    t.text     "address"
    t.string   "postal_code"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_foreign_key "distributors", "staffs", column: "staff_creator_id"
  add_foreign_key "supplier_contact_infos", "supplier_suppliers"
end
