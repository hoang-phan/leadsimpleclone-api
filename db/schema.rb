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

ActiveRecord::Schema[7.1].define(version: 2024_07_14_135740) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "contact_kind", ["personal", "work", "spouse", "partner", "other"]

  create_table "contacts", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "company_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_id"], name: "index_contacts_on_source_id"
  end

  create_table "emails", force: :cascade do |t|
    t.string "value", null: false
    t.enum "kind", default: "personal", null: false, enum_type: "contact_kind"
    t.bigint "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_emails_on_contact_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string "value", null: false
    t.enum "kind", default: "personal", null: false, enum_type: "contact_kind"
    t.bigint "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_phones_on_contact_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_sources_on_name", unique: true
  end

  add_foreign_key "contacts", "sources"
  add_foreign_key "emails", "contacts"
  add_foreign_key "phones", "contacts"
end
