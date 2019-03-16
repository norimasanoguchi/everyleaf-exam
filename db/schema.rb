ActiveRecord::Schema.define(version: 2019_03_12_124256) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.string "content", null: false
    t.string "label"
    t.string "priority"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "tasks", "users"
end
