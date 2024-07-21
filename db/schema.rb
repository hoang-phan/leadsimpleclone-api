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

ActiveRecord::Schema[7.1].define(version: 2024_07_21_013321) do
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

  create_table "lead_contacts", force: :cascade do |t|
    t.bigint "lead_id", null: false
    t.bigint "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_lead_contacts_on_contact_id"
    t.index ["lead_id"], name: "index_lead_contacts_on_lead_id"
  end

  create_table "lead_stages", force: :cascade do |t|
    t.bigint "lead_id", null: false
    t.bigint "stage_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lead_id"], name: "index_lead_stages_on_lead_id"
    t.index ["stage_id"], name: "index_lead_stages_on_stage_id"
  end

  create_table "leads", force: :cascade do |t|
    t.integer "emails_sent", default: 0, null: false
    t.integer "calls_made", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assignee_id"
    t.string "name", null: false
    t.index ["assignee_id"], name: "index_leads_on_assignee_id"
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

  create_table "stages", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.integer "kind", default: 0, null: false
    t.integer "order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order"], name: "index_stages_on_order"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "contacts", "sources"
  add_foreign_key "emails", "contacts"
  add_foreign_key "lead_contacts", "contacts"
  add_foreign_key "lead_contacts", "leads"
  add_foreign_key "lead_stages", "leads"
  add_foreign_key "lead_stages", "stages"
  add_foreign_key "leads", "users", column: "assignee_id"
  add_foreign_key "phones", "contacts"
end
