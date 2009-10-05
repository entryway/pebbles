class InitialSchemaLoad < ActiveRecord::Migration
  def self.up
    create_table "addresses", :force => true do |t|
      t.string  "address_1",   :limit => 50
      t.string  "address_2",   :limit => 50
      t.string  "city",        :limit => 50
      t.string  "postal_code", :limit => 10
      t.boolean "is_shipping"
      t.string  "country",     :limit => 50
      t.string  "state",       :limit => 50
    end

    create_table "cart_items", :force => true do |t|
      t.integer  "product_id"
      t.integer  "cart_id"
      t.integer  "quantity"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "variant_id"
    end

    create_table "carts", :force => true do |t|
      t.string   "name",           :limit => 40
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "promo_code",     :limit => 30,                               :default => ""
      t.decimal  "promo_discount",               :precision => 8, :scale => 2, :default => 0.0
      t.boolean  "free_shipping",                                              :default => false
    end

    create_table "categories", :force => true do |t|
      t.integer "parent_id"
      t.string  "name"
      t.integer "lft"
      t.integer "rgt"
      t.integer "position"
      t.text    "description"
      t.boolean "active",      :default => true
    end

    create_table "categories_products", :id => false, :force => true do |t|
      t.integer "product_id"
      t.integer "category_id"
    end

    add_index "categories_products", ["category_id"], :name => "index_categories_products_on_category_id"
    add_index "categories_products", ["category_id"], :name => "index_categories_suppliers_on_category_id"
    add_index "categories_products", ["product_id"], :name => "index_categories_products_on_product_id"
    add_index "categories_products", ["product_id"], :name => "index_categories_suppliers_on_supplier_id"

    create_table "category_images", :force => true do |t|
      t.string  "filename"
      t.integer "category_id"
    end

    create_table "featured_products", :force => true do |t|
      t.integer "product_id"
    end

    create_table "flat_rate_shippings", :force => true do |t|
      t.integer "item_low"
      t.integer "item_high"
      t.integer "weight_low"
      t.integer "weight_high"
      t.integer "order_total_low"
      t.integer "order_total_high"
      t.integer "shipping_method_id"
      t.decimal "flat_rate"
    end

    create_table "fulfillment_codes", :force => true do |t|
      t.integer  "item_low"
      t.integer  "item_high"
      t.string   "code",               :limit => 20
      t.integer  "shipping_method_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "logged_exceptions", :force => true do |t|
      t.string   "exception_class"
      t.string   "controller_name"
      t.string   "action_name"
      t.text     "message"
      t.text     "backtrace"
      t.text     "environment"
      t.text     "request"
      t.datetime "created_at"
    end

    create_table "order_items", :force => true do |t|
      t.integer  "product_id"
      t.integer  "variant_id"
      t.integer  "order_id"
      t.integer  "quantity"
      t.decimal  "weight",                           :precision => 8, :scale => 2, :default => 0.0
      t.boolean  "drop_ship"
      t.integer  "supplier_id"
      t.string   "product_name",       :limit => 50
      t.decimal  "price",                            :precision => 8, :scale => 2, :default => 0.0
      t.decimal  "drop_shipping_cost",               :precision => 8, :scale => 2, :default => 0.0
      t.datetime "updated_at"
      t.datetime "created_at"
    end

    create_table "order_transactions", :force => true do |t|
      t.integer  "order_id"
      t.integer  "amount"
      t.boolean  "success"
      t.string   "reference"
      t.string   "action"
      t.text     "params"
      t.boolean  "test"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "message"
    end

    create_table "orders", :force => true do |t|
      t.string   "full_name",             :limit => 50
      t.string   "email",                 :limit => 100
      t.string   "phone_number",          :limit => 50
      t.string   "customer_ip",           :limit => 25
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "order_number"
      t.decimal  "shipment_weight_total",                :precision => 8, :scale => 2, :default => 0.0
      t.decimal  "product_cost",                         :precision => 8, :scale => 2, :default => 0.0
      t.decimal  "shipping_cost",                        :precision => 8, :scale => 2, :default => 0.0
      t.decimal  "tax",                                  :precision => 8, :scale => 2, :default => 0.0
      t.decimal  "drop_shipping_cost",                   :precision => 8, :scale => 2, :default => 0.0
      t.text     "admin_notes"
      t.integer  "shipping_address_id"
      t.integer  "billing_address_id"
      t.integer  "amount"
      t.string   "state",                                                              :default => "pending"
      t.integer  "order_type"
      t.string   "business",              :limit => 50
      t.string   "ebay_item_number",      :limit => 30
      t.string   "ebay_auction_id",       :limit => 30
      t.string   "company",               :limit => 50,                                :default => ""
      t.string   "shipping_method",       :limit => 50,                                :default => ""
      t.integer  "delivery_status",                                                    :default => 1
      t.string   "credit_card_display",   :limit => 20
      t.integer  "shipping_method_id"
      t.string   "promo_code",            :limit => 30,                                :default => ""
      t.decimal  "promo_discount",                       :precision => 8, :scale => 2, :default => 0.0
      t.boolean  "free_shipping",                                                      :default => false
    end

    create_table "out_of_stock_option_selections", :force => true do |t|
      t.integer  "out_of_stock_option_id"
      t.integer  "product_option_selection_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "out_of_stock_options", :force => true do |t|
      t.integer  "product_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "product_image_thumbnails", :force => true do |t|
      t.integer "product_image_id"
      t.string  "filename"
    end

    create_table "product_images", :force => true do |t|
      t.string  "filename"
      t.integer "product_id"
    end

    create_table "product_large_images", :force => true do |t|
     t.integer "product_image_id"
     t.string  "filename"
    end

    create_table "product_option_instances", :force => true do |t|
      t.integer "product_id"
      t.integer "product_option_id"
    end

    add_index "product_option_instances", ["product_id"], :name => "index_product_option_instances_on_product_id"
    add_index "product_option_instances", ["product_option_id"], :name => "index_product_option_instances_on_product_option_id"

    create_table "product_option_selection_images", :force => true do |t|
      t.integer "parent_id"
      t.string  "content_type"
      t.string  "filename"
      t.string  "thumbnail"
      t.integer "size"
      t.integer "width"
      t.integer "height"
      t.integer "product_option_selection_id"
    end

    create_table "product_option_selections", :force => true do |t|
      t.string  "name",              :limit => 50,                                                :null => false
      t.decimal "price_adjustment",                :precision => 8, :scale => 2, :default => 0.0
      t.decimal "weight_adjustment",               :precision => 8, :scale => 2, :default => 0.0
      t.string  "sku_adjustment",    :limit => 50
      t.integer "product_option_id"
      t.integer "list_order",                                                    :default => 99
    end

    create_table "product_options", :force => true do |t|
      t.string  "name",           :limit => 50, :null => false
      t.integer "selection_type"
      t.text    "description"
    end

    create_table "products", :force => true do |t|
      t.string   "sku"
      t.string   "name",              :limit => 100
      t.string   "subname",           :limit => 50
      t.text     "short_description"
      t.decimal  "weight",                          :precision => 8, :scale => 2
      t.text     "admin_notes"
      t.integer  "vendor_id"
      t.decimal  "price",                           :precision => 8, :scale => 2, :default => 0.0
      t.boolean  "is_featured"
      t.text     "long_description"
      t.datetime "updated_at"
      t.datetime "created_at"
      t.boolean  "available",                                                     :default => true
      t.decimal  "wholesale_price",                 :precision => 8, :scale => 2
      t.decimal  "flat_rate_shipping"
      t.text     "keywords"
      t.text     "description"
      t.string   "title"
      t.decimal  "handling"
      t.integer  "shipping_type",                                                  :default => 0
      t.decimal  "length"
      t.decimal  "width"
      t.decimal  "height"
      t.integer  "inventory", :default => 0
      t.string   "image"
      t.string   "thumbnail"
    end

    create_table "promo_codes", :force => true do |t|
      t.string   "name",                 :limit => 150,                                                  :null => false
      t.string   "code",                 :limit => 30,                                :default => "",    :null => false
      t.decimal  "dollar_discount",                     :precision => 8, :scale => 2, :default => 0.0
      t.decimal  "percent_discount",                    :precision => 8, :scale => 2, :default => 0.0
      t.boolean  "free_shipping",                                                     :default => false
      t.text     "note",                                                              :default => ""
      t.boolean  "first_time_only",                                                   :default => false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.decimal  "minimum_order_amount",                :precision => 8, :scale => 2, :default => 0.0
    end

    create_table "quantity_discounts", :force => true do |t|
      t.decimal "price_per_product", :precision => 8, :scale => 5, :default => 0.0
      t.integer "product_id"
      t.integer "quantity_low",                                    :default => 0
      t.integer "quantity_high",                                   :default => 0
    end

    create_table "regions", :force => true do |t|
      t.string "name", :limit => 50
    end

    create_table "sessions", :force => true do |t|
      t.string   "session_id"
      t.text     "data"
      t.datetime "updated_at"
    end

    add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
    add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

    create_table "shipping_methods", :force => true do |t|
      t.string  "name",              :limit => 50
      t.boolean "default_selection"
      t.integer "region_id"
      t.string  "fulfillment_code"
      t.decimal "base_price"
      t.integer "cost_of_subtotal"
      t.integer "cost_per_weight"
      t.decimal "cost_per_item",                    :precision => 8, :scale => 2, :default => 0.0
    end

    create_table "shipping_providers", :force => true do |t|
      t.string  "name",             :limit => 50
      t.integer "shipping_rate_id"
    end

    create_table "store_images", :force => true do |t|
      t.integer "parent_id"
      t.string  "content_type"
      t.string  "filename"
      t.string  "thumbnail"
      t.integer "size"
      t.integer "width"
      t.integer "height"
      t.integer "store_id"
    end

    create_table "stores", :force => true do |t|
      t.string "address",   :limit => 200
      t.string "city",      :limit => 50
      t.string "state",     :limit => 50
      t.string "zip",       :limit => 10
      t.string "storename", :limit => 50
      t.string "hours",     :limit => 50
      t.string "url",       :limit => 50
      t.string "phone",     :limit => 50
      t.string "country",   :limit => 50
      t.float  "lat"
      t.float  "lng"
    end

    create_table "tax_rates", :force => true do |t|
      t.string  "state",       :limit => 2
      t.string  "postal_code", :limit => 10
      t.decimal "rate",                      :precision => 8, :scale => 5, :default => 0.0
    end

    create_table "users", :force => true do |t|
      t.string   "login"
      t.string   "email"
      t.string   "crypted_password",          :limit => 40
      t.string   "salt",                      :limit => 40
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "remember_token"
      t.datetime "remember_token_expires_at"
      t.string   "role",                      :limit => 20
    end

    add_index "users", ["role"], :name => "index_users_on_role"

    create_table "vendors", :force => true do |t|
      t.string  "name",        :limit => 50,                                                :null => false
      t.text    "description"
      t.boolean "active"
      t.boolean "drop_ship"
      t.decimal "shipping",                  :precision => 8, :scale => 2, :default => 0.0
      t.text    "admin_notes"
    end
  end

  def self.down
  end
end
