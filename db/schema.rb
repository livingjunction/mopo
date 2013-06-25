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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130515072517) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "activities", ["trackable_id"], :name => "index_activities_on_trackable_id"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "assets", :force => true do |t|
    t.integer  "scrap_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.string   "type"
    t.integer  "user_id"
  end

  create_table "assignments", :force => true do |t|
    t.integer  "category_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "position"
  end

  add_index "assignments", ["category_id"], :name => "index_assignments_on_category_id"
  add_index "assignments", ["user_id"], :name => "index_assignments_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "scrap_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["scrap_id"], :name => "index_comments_on_scrap_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "flags", :force => true do |t|
    t.integer  "user_id"
    t.integer  "scrap_id"
    t.enum     "color",      :limit => [:green, :red, :yellow]
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "flags", ["scrap_id"], :name => "index_flags_on_scrap_id", :unique => true
  add_index "flags", ["user_id"], :name => "index_flags_on_user_id"

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "scrap_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "likes", ["user_id", "scrap_id"], :name => "index_likes_on_user_id_and_scrap_id", :unique => true

  create_table "links", :force => true do |t|
    t.string   "url"
    t.integer  "scrap_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "links", ["scrap_id"], :name => "index_links_on_scrap_id"
  add_index "links", ["user_id"], :name => "index_links_on_user_id"

  create_table "notifications", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "user_id"
    t.boolean  "is_read",     :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "notifications", ["activity_id"], :name => "index_notifications_on_activity_id"
  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "projects", :force => true do |t|
    t.integer  "assignment_id"
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
  end

  add_index "projects", ["assignment_id"], :name => "index_projects_on_assignment_id"

  create_table "scraps", :force => true do |t|
    t.integer  "project_id"
    t.text     "description"
    t.datetime "created_at",                                                                           :null => false
    t.datetime "updated_at",                                                                           :null => false
    t.integer  "user_id"
    t.enum     "privacy",        :limit => [:public, :registered, :project, :private],                 :null => false
    t.integer  "images_count",                                                         :default => 0,  :null => false
    t.integer  "videos_count",                                                         :default => 0,  :null => false
    t.integer  "audios_count",                                                         :default => 0,  :null => false
    t.integer  "files_count",                                                          :default => 0,  :null => false
    t.integer  "likes_count",                                                          :default => 0,  :null => false
    t.integer  "comments_count",                                                       :default => 0,  :null => false
    t.integer  "links_count",                                                          :default => 0,  :null => false
    t.string   "name",                                                                 :default => "", :null => false
    t.integer  "assignment_id"
  end

  add_index "scraps", ["assignment_id"], :name => "index_scraps_on_assignment_id"
  add_index "scraps", ["project_id"], :name => "index_scraps_on_project_id"
  add_index "scraps", ["user_id"], :name => "index_scraps_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                                  :default => "", :null => false
    t.string   "encrypted_password",                                     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
    t.string   "first_name",             :limit => 50,                   :default => "", :null => false
    t.string   "last_name",              :limit => 50,                   :default => "", :null => false
    t.enum     "role",                   :limit => [:student, :teacher],                 :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
