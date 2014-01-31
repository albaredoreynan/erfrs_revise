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

ActiveRecord::Schema.define(version: 20140131134541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "barangays", force: true do |t|
    t.integer  "municipality_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "barangays", ["municipality_id"], name: "index_barangays_on_municipality_id", using: :btree

  create_table "municipalities", force: true do |t|
    t.integer  "province_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "municipalities", ["province_id"], name: "index_municipalities_on_province_id", using: :btree

  create_table "provinces", force: true do |t|
    t.integer  "region_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provinces", ["region_id"], name: "index_provinces_on_region_id", using: :btree

  create_table "regions", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subprojects", force: true do |t|
    t.string   "status"
    t.string   "title"
    t.integer  "region_id"
    t.integer  "province_id"
    t.integer  "municipality_id"
    t.integer  "barangay_id"
    t.string   "category"
    t.string   "physical_target"
    t.string   "cost_parameter"
    t.string   "mode_of_implementation"
    t.string   "description"
    t.integer  "fund_source_id"
    t.decimal  "grant_amount_direct_cost",        precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "grant_amount_indirect_cost",      precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "lcc_blgu_direct_cost",            precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "lcc_blgu_indirect_cost",          precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "community_direct_cost",           precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "community_indirect_cost",         precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "mlgu_direct_cost",                precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "mlgu_indirect_cost",              precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "plgu_others_direct_cost",         precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "plgu_others_indirect_cost",       precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "total_lcc_cash_direct_cost",      precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "total_lcc_cash_indirect_cost",    precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "total_lcc_in_kind_direct_cost",   precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "total_lcc_in_kind_indirect_cost", precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "first_tranch_amount",             precision: 15, scale: 2, default: 0.0, null: false
    t.datetime "first_tranch_date_required"
    t.decimal  "second_tranch_amount",            precision: 15, scale: 2, default: 0.0, null: false
    t.datetime "second_tranch_date_required"
    t.decimal  "third_tranch_amount",             precision: 15, scale: 2, default: 0.0, null: false
    t.datetime "third_tranch_date_required"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subprojects", ["barangay_id"], name: "index_subprojects_on_barangay_id", using: :btree
  add_index "subprojects", ["municipality_id"], name: "index_subprojects_on_municipality_id", using: :btree
  add_index "subprojects", ["province_id"], name: "index_subprojects_on_province_id", using: :btree
  add_index "subprojects", ["region_id"], name: "index_subprojects_on_region_id", using: :btree

end
