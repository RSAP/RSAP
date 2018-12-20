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

ActiveRecord::Schema.define(version: 20181211031411) do

  create_table "amizades", force: :cascade do |t|
    t.integer "id_usuario"
    t.integer "id_amigo"
    t.string "create"
    t.string "destroy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.boolean "accepted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grupos", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grupos_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "grupo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grupo_id"], name: "index_grupos_users_on_grupo_id"
    t.index ["user_id"], name: "index_grupos_users_on_user_id"
  end

  create_table "moderadores", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "grupo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grupo_id"], name: "index_moderadores_on_grupo_id"
    t.index ["user_id"], name: "index_moderadores_on_user_id"
  end

  create_table "perfil_externos", force: :cascade do |t|
    t.string "nome"
    t.string "link"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_perfil_externos_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "titulo"
    t.string "categoria"
    t.text "texto"
    t.boolean "e_de_grupo", default: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imagem_file_name"
    t.string "imagem_content_type"
    t.integer "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "posts_de_grupos", force: :cascade do |t|
    t.integer "post_id"
    t.integer "grupo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grupo_id"], name: "index_posts_de_grupos_on_grupo_id"
    t.index ["post_id"], name: "index_posts_de_grupos_on_post_id"
  end

  create_table "solicitacoes_grupo", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "grupo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grupo_id"], name: "index_solicitacoes_grupo_on_grupo_id"
    t.index ["user_id"], name: "index_solicitacoes_grupo_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nome", default: "", null: false
    t.string "email", default: "", null: false
    t.text "descricao", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
