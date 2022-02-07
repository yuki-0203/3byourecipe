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

ActiveRecord::Schema.define(version: 20_220_206_124_154) do
  create_table 'favorites', force: :cascade do |t|
    t.integer 'recipe_id', null: false
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'impressions', force: :cascade do |t|
    t.integer 'recipe_id', null: false
    t.integer 'user_id', null: false
    t.text 'impression', null: false
    t.text 'image_id'
    t.text 'reply_comment'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'materials', force: :cascade do |t|
    t.integer 'recipe_id', null: false
    t.string 'name', null: false
    t.string 'quantity', null: false
    t.integer 'serving', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'recipe_tags', force: :cascade do |t|
    t.integer 'recipe_id', null: false
    t.integer 'tag_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'recipes', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.string 'name', null: false
    t.text 'introduction', null: false
    t.text 'note'
    t.text 'image_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'steps', force: :cascade do |t|
    t.integer 'recipe_id', null: false
    t.text 'explanation', null: false
    t.text 'image_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'last_name', null: false
    t.string 'first_name', null: false
    t.integer 'phone_number', null: false
    t.integer 'is_gender', null: false
    t.string 'nickname'
    t.text 'introduction'
    t.text 'image_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['first_name'], name: 'index_users_on_first_name'
    t.index ['is_gender'], name: 'index_users_on_is_gender'
    t.index ['last_name'], name: 'index_users_on_last_name'
    t.index ['phone_number'], name: 'index_users_on_phone_number', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
