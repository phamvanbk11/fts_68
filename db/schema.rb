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

ActiveRecord::Schema.define(version: 20160920013948) do

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "content"
    t.boolean  "is_correct"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "exams", force: :cascade do |t|
    t.integer  "subject_id"
    t.integer  "user_id"
    t.integer  "state"
    t.integer  "spent_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "exams", ["subject_id"], name: "index_exams_on_subject_id"
  add_index "exams", ["user_id"], name: "index_exams_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.integer  "subject_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["subject_id"], name: "index_posts_on_subject_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "questions", force: :cascade do |t|
    t.integer  "subject_id"
    t.string   "content"
    t.integer  "question_type"
    t.integer  "state"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "questions", ["subject_id"], name: "index_questions_on_subject_id"
  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "results", force: :cascade do |t|
    t.integer  "exam_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "results", ["answer_id"], name: "index_results_on_answer_id"
  add_index "results", ["exam_id"], name: "index_results_on_exam_id"
  add_index "results", ["question_id"], name: "index_results_on_question_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "duration"
    t.integer  "number_of_questions"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "subjects", ["user_id"], name: "index_subjects_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "chatwordId"
    t.boolean  "admin"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
