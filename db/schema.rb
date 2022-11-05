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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160210105855) do

  create_table "answers", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id",    null: false
    t.integer  "ticket_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "answers", ["ticket_id"], name: "index_answers_on_ticket_id"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "attachments", force: :cascade do |t|
    t.string   "filename"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "attachments", ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invites", force: :cascade do |t|
    t.integer  "ticket_id"
    t.string   "key"
    t.datetime "used_at"
    t.datetime "expired_at"
    t.string   "ip"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "invites", ["ticket_id"], name: "index_invites_on_ticket_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "link"
  end

  create_table "projects_users", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "projects_users", ["project_id"], name: "index_projects_users_on_project_id"
  add_index "projects_users", ["user_id"], name: "index_projects_users_on_user_id"

  create_table "tickets", force: :cascade do |t|
    t.text     "text"
    t.integer  "project_id"
    t.integer  "category_id"
    t.boolean  "closed"
    t.datetime "closed_at"
    t.integer  "status"
    t.string   "link"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tickets", ["category_id"], name: "index_tickets_on_category_id"
  add_index "tickets", ["project_id"], name: "index_tickets_on_project_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
