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

ActiveRecord::Schema.define(version: 20170508064250) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters"
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "course_registers", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "address"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "education_about_translations", force: :cascade do |t|
    t.integer  "education_about_id", null: false
    t.string   "locale",             null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "title"
    t.text     "content"
    t.index ["education_about_id"], name: "index_education_about_translations_on_education_about_id", using: :btree
    t.index ["locale"], name: "index_education_about_translations_on_locale", using: :btree
  end

  create_table "education_abouts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "education_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_education_categories_on_deleted_at", using: :btree
  end

  create_table "education_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user_id"], name: "index_education_comments_on_user_id", using: :btree
  end

  create_table "education_course_members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_education_course_members_on_user_id", using: :btree
  end

  create_table "education_course_translations", force: :cascade do |t|
    t.integer  "education_course_id", null: false
    t.string   "locale",              null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "detail"
    t.index ["education_course_id"], name: "index_education_course_translations_on_education_course_id", using: :btree
    t.index ["locale"], name: "index_education_course_translations_on_locale", using: :btree
  end

  create_table "education_courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "training_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "cost"
    t.text     "place"
    t.text     "schedule"
    t.datetime "deadline_register"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "education_feedbacks", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.string   "phone_number"
    t.string   "subject"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "education_group_translations", force: :cascade do |t|
    t.integer  "education_group_id", null: false
    t.string   "locale",             null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "description"
    t.index ["education_group_id"], name: "index_education_group_translations_on_education_group_id", using: :btree
    t.index ["locale"], name: "index_education_group_translations_on_locale", using: :btree
  end

  create_table "education_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "education_images", force: :cascade do |t|
    t.string   "url"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["imageable_id"], name: "index_education_images_on_imageable_id", using: :btree
    t.index ["imageable_type"], name: "index_education_images_on_imageable_type", using: :btree
  end

  create_table "education_learning_program_translations", force: :cascade do |t|
    t.integer  "education_learning_program_id", null: false
    t.string   "locale",                        null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "description"
    t.text     "name"
    t.index ["education_learning_program_id"], name: "index_8b0cacfb59cf9e0162ebe217e09209051f6e9f59", using: :btree
    t.index ["locale"], name: "index_education_learning_program_translations_on_locale", using: :btree
  end

  create_table "education_learning_programs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "education_permissions", force: :cascade do |t|
    t.string   "entry"
    t.text     "optional"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_education_permissions_on_group_id", using: :btree
  end

  create_table "education_post_translations", force: :cascade do |t|
    t.integer  "education_post_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "title"
    t.index ["education_post_id"], name: "index_education_post_translations_on_education_post_id", using: :btree
    t.index ["locale"], name: "index_education_post_translations_on_locale", using: :btree
  end

  create_table "education_posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "category_id"
    t.integer  "user_id"
    t.string   "cover_photo"
    t.string   "tags"
    t.integer  "comments_count", default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "deleted_at"
    t.integer  "post_type"
    t.index ["deleted_at"], name: "index_education_posts_on_deleted_at", using: :btree
    t.index ["user_id"], name: "index_education_posts_on_user_id", using: :btree
  end

  create_table "education_program_members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "learning_program_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["user_id"], name: "index_education_program_members_on_user_id", using: :btree
  end

  create_table "education_project_members", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_education_project_members_on_user_id", using: :btree
  end

  create_table "education_project_techniques", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "technique_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_education_project_techniques_on_deleted_at", using: :btree
  end

  create_table "education_project_translations", force: :cascade do |t|
    t.integer  "education_project_id", null: false
    t.string   "locale",               null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.text     "description"
    t.text     "core_features"
    t.text     "release_note"
    t.index ["education_project_id"], name: "index_education_project_translations_on_education_project_id", using: :btree
    t.index ["locale"], name: "index_education_project_translations_on_locale", using: :btree
  end

  create_table "education_projects", force: :cascade do |t|
    t.string   "name"
    t.string   "git_repo"
    t.string   "server_info"
    t.string   "pm_url"
    t.boolean  "is_project"
    t.string   "plat_form"
    t.integer  "comments_count", default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_education_projects_on_deleted_at", using: :btree
  end

  create_table "education_rates", force: :cascade do |t|
    t.float    "rate",          default: 0.0
    t.integer  "user_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_education_rates_on_user_id", using: :btree
  end

  create_table "education_socials", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_education_socials_on_user_id", using: :btree
  end

  create_table "education_technique_translations", force: :cascade do |t|
    t.integer  "education_technique_id", null: false
    t.string   "locale",                 null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.text     "description"
    t.index ["education_technique_id"], name: "index_eceb63ab3bdbe51a9b3eb88ff07c8841a870b817", using: :btree
    t.index ["locale"], name: "index_education_technique_translations_on_locale", using: :btree
  end

  create_table "education_techniques", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_education_techniques_on_deleted_at", using: :btree
  end

  create_table "education_training_techniques", force: :cascade do |t|
    t.integer  "training_id"
    t.integer  "technique_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_education_training_techniques_on_deleted_at", using: :btree
  end

  create_table "education_training_translations", force: :cascade do |t|
    t.integer  "education_training_id", null: false
    t.string   "locale",                null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.text     "description"
    t.index ["education_training_id"], name: "index_education_training_translations_on_education_training_id", using: :btree
    t.index ["locale"], name: "index_education_training_translations_on_locale", using: :btree
  end

  create_table "education_trainings", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.text     "usage"
    t.text     "reason"
    t.text     "learner"
    t.text     "benefit"
    t.integer  "duration"
    t.integer  "cost"
    t.index ["deleted_at"], name: "index_education_trainings_on_deleted_at", using: :btree
  end

  create_table "education_user_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.boolean  "is_default_group"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user_id"], name: "index_education_user_groups_on_user_id", using: :btree
  end

  create_table "follows", force: :cascade do |t|
    t.string   "followable_type",                 null: false
    t.integer  "followable_id",                   null: false
    t.string   "follower_type",                   null: false
    t.integer  "follower_id",                     null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables", using: :btree
    t.index ["follower_id", "follower_type"], name: "fk_follows", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "picture"
    t.text     "caption"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["imageable_id"], name: "index_images_on_imageable_id", using: :btree
    t.index ["imageable_type"], name: "index_images_on_imageable_type", using: :btree
  end

  create_table "info_users", force: :cascade do |t|
    t.integer  "relationship_status"
    t.text     "introduce"
    t.string   "quote"
    t.string   "ambition"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["user_id"], name: "index_info_users_on_user_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "phone"
    t.integer  "role",                   default: 0
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.integer  "education_status",       default: 1
    t.integer  "cover_image_id"
    t.integer  "avatar_id"
    t.string   "provider"
    t.string   "uid"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "course_registers", "education_courses", column: "course_id"
  add_foreign_key "education_comments", "users"
  add_foreign_key "education_course_members", "education_courses", column: "course_id"
  add_foreign_key "education_course_members", "users"
  add_foreign_key "education_courses", "education_trainings", column: "training_id"
  add_foreign_key "education_permissions", "education_groups", column: "group_id"
  add_foreign_key "education_posts", "education_categories", column: "category_id"
  add_foreign_key "education_posts", "users"
  add_foreign_key "education_program_members", "education_learning_programs", column: "learning_program_id"
  add_foreign_key "education_program_members", "users"
  add_foreign_key "education_project_members", "education_projects", column: "project_id"
  add_foreign_key "education_project_members", "users"
  add_foreign_key "education_project_techniques", "education_projects", column: "project_id"
  add_foreign_key "education_project_techniques", "education_techniques", column: "technique_id"
  add_foreign_key "education_rates", "users"
  add_foreign_key "education_socials", "users"
  add_foreign_key "education_training_techniques", "education_techniques", column: "technique_id"
  add_foreign_key "education_training_techniques", "education_trainings", column: "training_id"
  add_foreign_key "education_user_groups", "education_groups", column: "group_id"
  add_foreign_key "education_user_groups", "users"
  add_foreign_key "info_users", "users"
end
