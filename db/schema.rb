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

ActiveRecord::Schema.define(:version => 20120329000703) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
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

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "cines", :force => true do |t|
    t.string   "nombre"
    t.string   "direccion"
    t.string   "query"
    t.string   "country"
    t.string   "tel"
    t.integer  "zona_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "external_id"
    t.string   "localidad"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
  end

  create_table "generos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "horarios", :force => true do |t|
    t.integer "cine_id"
    t.integer "pelicula_id"
    t.string  "horas"
  end

  create_table "peliculas", :force => true do |t|
    t.string   "titulo"
    t.string   "imagen"
    t.text     "descripcion"
    t.string   "titulo_original"
    t.string   "pais"
    t.integer  "anio"
    t.string   "duracion"
    t.string   "calificacion"
    t.date     "estreno"
    t.string   "web"
    t.string   "genero"
    t.string   "interpretes"
    t.string   "director"
    t.string   "guionista"
    t.string   "fotografia"
    t.string   "musica"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "external_id"
    t.boolean  "es_estreno"
    t.string   "brief"
    t.string   "imagen_chica"
  end

  create_table "requests", :force => true do |t|
    t.string   "model"
    t.string   "phone"
    t.string   "query"
    t.string   "country"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "zonas", :force => true do |t|
    t.string   "nombre"
    t.decimal  "lat",        :precision => 10, :scale => 0
    t.decimal  "long",       :precision => 10, :scale => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

end
