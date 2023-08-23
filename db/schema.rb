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

ActiveRecord::Schema[7.0].define(version: 2023_08_23_032156) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "commenter"
    t.text "body"
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "followers", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "following_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "title"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_playlists_on_user_id"
  end

  create_table "post_categories", force: :cascade do |t|
    t.integer "post_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_revisions", force: :cascade do |t|
    t.integer "post_id", null: false
    t.string "title"
    t.string "topic"
    t.text "description"
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_revisions_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "topic"
    t.text "text"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "status"
    t.integer "views"
  end

  create_table "posts_playlists", id: false, force: :cascade do |t|
    t.integer "post_id"
    t.integer "playlist_id"
    t.index ["playlist_id"], name: "index_posts_playlists_on_playlist_id"
    t.index ["post_id", "playlist_id"], name: "index_posts_playlists_on_post_id_and_playlist_id", unique: true
    t.index ["post_id"], name: "index_posts_playlists_on_post_id"
  end

  create_table "posts_tables", force: :cascade do |t|
    t.string "title"
    t.string "topic"
    t.text "text"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.text "bio"
    t.string "name"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "interested_topics"
    t.integer "save_for_later"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "saved_posts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_saved_posts_on_post_id"
    t.index ["user_id"], name: "index_saved_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "playlists", "users"
  add_foreign_key "post_revisions", "posts"
  add_foreign_key "profiles", "users"
  add_foreign_key "saved_posts", "posts"
  add_foreign_key "saved_posts", "users"
end
