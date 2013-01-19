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

ActiveRecord::Schema.define(:version => 20130118135926) do

  create_table "addresses", :force => true do |t|
    t.string   "street_no"
    t.string   "area"
    t.string   "city"
    t.integer  "postal_code"
    t.string   "country"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "name"
    t.string   "state"
  end

  create_table "brands", :force => true do |t|
    t.string   "brand"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "brands", ["slug"], :name => "index_brands_on_slug", :unique => true

  create_table "brands_categories", :id => false, :force => true do |t|
    t.integer "brand_id"
    t.integer "category_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "category"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "visible",    :default => true
    t.string   "slug"
    t.integer  "parent_id"
  end

  add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true

  create_table "categories_products", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "colours", :force => true do |t|
    t.string "colour"
  end

  create_table "comments", :force => true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "product_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "quantity",                                  :default => 1
    t.decimal  "price",      :precision => 10, :scale => 2
    t.integer  "order_id"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "amount",     :precision => 11, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.string   "state"
    t.integer  "address_id"
  end

  create_table "product_attributes", :force => true do |t|
    t.string   "product_attributes"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "product_attributes_prototypes", :id => false, :force => true do |t|
    t.integer "prototype_id"
    t.integer "product_attribute_id"
  end

  create_table "product_details", :force => true do |t|
    t.integer  "product_attribute_id"
    t.integer  "product_id"
    t.text     "details"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "product"
    t.decimal  "price",       :precision => 10, :scale => 2
    t.integer  "brand_id"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.string   "slug"
    t.decimal  "mrp",         :precision => 10, :scale => 2
    t.text     "description"
    t.integer  "available",                                  :default => 0
  end

  add_index "products", ["slug"], :name => "index_products_on_slug", :unique => true

  create_table "products_prototypes", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "prototype_id"
  end

  create_table "prototypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "rating",     :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "sizes", :force => true do |t|
    t.string "size"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.boolean  "admin",                                          :default => false
    t.decimal  "wallet",          :precision => 10, :scale => 2, :default => 10000.0
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.boolean  "super",                                          :default => false
  end

  create_table "varients", :force => true do |t|
    t.integer  "product_id"
    t.decimal  "mrp",        :precision => 10, :scale => 2
    t.decimal  "price",      :precision => 10, :scale => 2
    t.integer  "available",                                 :default => 0
    t.integer  "colour_id"
    t.integer  "size_id"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

end
