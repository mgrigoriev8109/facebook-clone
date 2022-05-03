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

ActiveRecord::Schema[7.0].define(version: 2022_05_02_170021) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendship_requests", force: :cascade do |t|
    t.bigint "request_provider_id"
    t.bigint "request_recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_provider_id"], name: "index_friendship_requests_on_request_provider_id"
    t.index ["request_recipient_id"], name: "index_friendship_requests_on_request_recipient_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "friendship_provider_id"
    t.bigint "friendship_recipient_id"
    t.index ["friendship_provider_id"], name: "index_friendships_on_friendship_provider_id"
    t.index ["friendship_recipient_id"], name: "index_friendships_on_friendship_recipient_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "friendship_request_id"
    t.boolean "notification_viewed", default: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friendship_request_id"], name: "index_notifications_on_friendship_request_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
