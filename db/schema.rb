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

ActiveRecord::Schema.define(version: 20141110041323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "barangays", force: true do |t|
    t.integer  "municipality_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nscb_code"
  end

  add_index "barangays", ["municipality_id"], name: "index_barangays_on_municipality_id", using: :btree

  create_table "cgdps", force: true do |t|
    t.integer  "municipality_id"
    t.integer  "year"
    t.string   "status"
    t.string   "saa_number"
    t.datetime "saa_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cgdps", ["municipality_id"], name: "index_cgdps_on_municipality_id", using: :btree

  create_table "designations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "designation_type"
  end

  create_table "fund_allocations", force: true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal  "amount",         precision: 15, scale: 2, default: 0.0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fund_source_id"
    t.integer  "year"
  end

  create_table "fund_sources", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "code"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fund_source_id"
  end

  create_table "muni_fund_allocations", force: true do |t|
    t.integer  "year"
    t.decimal  "amount",          precision: 15, scale: 2, default: 0.0, null: false
    t.integer  "municipality_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cycle"
  end

  create_table "municipalities", force: true do |t|
    t.integer  "province_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.decimal  "total_grant_allocation", precision: 15, scale: 2
  end

  add_index "municipalities", ["group_id"], name: "index_municipalities_on_group_id", using: :btree
  add_index "municipalities", ["province_id"], name: "index_municipalities_on_province_id", using: :btree

  create_table "news_informations", force: true do |t|
    t.string   "title"
    t.datetime "publish_start"
    t.datetime "publish_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
    t.string   "news_image_file_name"
    t.string   "news_image_content_type"
    t.integer  "news_image_file_size"
    t.datetime "news_image_updated_at"
  end

  create_table "provinces", force: true do |t|
    t.integer  "region_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provinces", ["region_id"], name: "index_provinces_on_region_id", using: :btree

  create_table "regional_officers", force: true do |t|
    t.string   "name"
    t.string   "designation"
    t.string   "ro_type"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "box"
  end

  add_index "regional_officers", ["region_id"], name: "index_regional_officers_on_region_id", using: :btree

  create_table "regions", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "for_regional_accounting"
    t.string   "for_management_division_head"
    t.string   "for_regional_director"
    t.string   "for_asst_regional_director_opt"
    t.string   "for_asst_regional_director_adm"
    t.string   "for_budget_officer"
    t.integer  "equi_code"
    t.text     "address_region"
  end

  create_table "request_for_fund_releases", force: true do |t|
    t.integer  "subproject_id"
    t.string   "status"
    t.string   "rfr_type"
    t.datetime "request_date"
    t.string   "bank_account_number"
    t.string   "address"
    t.string   "branch"
    t.string   "city"
    t.string   "province"
    t.string   "phone"
    t.decimal  "amount_approve"
    t.string   "remarks"
    t.string   "obr_number"
    t.datetime "obr_date"
    t.string   "dv_number"
    t.datetime "dv_date"
    t.string   "check_number"
    t.string   "check_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_name"
    t.integer  "requested_by_first"
    t.string   "designation_first"
    t.datetime "date_first"
    t.integer  "requested_by_second"
    t.string   "designation_second"
    t.datetime "date_second"
    t.datetime "date_received"
    t.integer  "reviewed_by_first"
    t.string   "rev_designation_first"
    t.datetime "rev_date_first"
    t.integer  "reviewed_by_second"
    t.string   "rev_designation_second"
    t.datetime "rev_date_second"
    t.datetime "srpmo_date_received"
    t.integer  "srpmo_reviewed_by"
    t.string   "srpmo_designation"
    t.datetime "srpmo_date"
    t.integer  "srpmo_recommend_by"
    t.string   "srpmo_rec_designation"
    t.datetime "srpmo_rec_date"
    t.datetime "rpmo_date_received"
    t.integer  "rpmo_approved_by"
    t.string   "rpmo_designation"
    t.datetime "rpmo_date"
    t.boolean  "approved_as_requested"
    t.integer  "tranch_for"
    t.integer  "exchange_rate"
    t.string   "excel_remark"
    t.decimal  "amount_requested",       precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "amount_contingency",     precision: 15, scale: 2, default: 0.0, null: false
  end

  create_table "rfr_signatories", force: true do |t|
    t.integer  "request_for_fund_release_id"
    t.integer  "regional_officer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "group"
    t.string   "sign_type"
  end

  add_index "rfr_signatories", ["regional_officer_id"], name: "index_rfr_signatories_on_regional_officer_id", using: :btree
  add_index "rfr_signatories", ["request_for_fund_release_id"], name: "index_rfr_signatories_on_request_for_fund_release_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "code"
    t.integer  "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_regions", force: true do |t|
    t.integer  "region_id"
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_regions", ["region_id"], name: "index_sub_regions_on_region_id", using: :btree

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
    t.decimal  "grant_amount_direct_cost",           precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "grant_amount_indirect_cost",         precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "lcc_blgu_direct_cost",               precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "lcc_blgu_indirect_cost",             precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "community_direct_cost",              precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "community_indirect_cost",            precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "mlgu_direct_cost",                   precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "mlgu_indirect_cost",                 precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "plgu_others_direct_cost",            precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "plgu_others_indirect_cost",          precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "total_lcc_cash_direct_cost",         precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "total_lcc_cash_indirect_cost",       precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "total_lcc_in_kind_direct_cost",      precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "total_lcc_in_kind_indirect_cost",    precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "first_tranch_amount",                precision: 15, scale: 2, default: 0.0, null: false
    t.datetime "first_tranch_date_required"
    t.decimal  "second_tranch_amount",               precision: 15, scale: 2, default: 0.0, null: false
    t.datetime "second_tranch_date_required"
    t.decimal  "third_tranch_amount",                precision: 15, scale: 2, default: 0.0, null: false
    t.datetime "third_tranch_date_required"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.date     "date_encoded"
    t.date     "date_of_mibf"
    t.integer  "cycle"
    t.integer  "group_id"
    t.decimal  "grant_amount_contingency_cost",      precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "lcc_blgu_contingency_cost",          precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "community_contingency_cost",         precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "mlgu_contingency_cost",              precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "plgu_others_contingency_cost",       precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "total_lcc_cash_contingency_cost",    precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "total_lcc_in_kind_contingency_cost", precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "first_tranch_revised_amount",        precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "second_tranch_revised_amount",       precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "third_tranch_revised_amount",        precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "first_tranch_amount_release",        precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "second_tranch_amount_release",       precision: 15, scale: 2, default: 0.0, null: false
    t.decimal  "third_tranch_amount_release",        precision: 15, scale: 2, default: 0.0, null: false
    t.integer  "tranch_one_percentage"
    t.integer  "tranch_two_percentage"
    t.integer  "tranch_three_percentage"
  end

  add_index "subprojects", ["barangay_id"], name: "index_subprojects_on_barangay_id", using: :btree
  add_index "subprojects", ["municipality_id"], name: "index_subprojects_on_municipality_id", using: :btree
  add_index "subprojects", ["province_id"], name: "index_subprojects_on_province_id", using: :btree
  add_index "subprojects", ["region_id"], name: "index_subprojects_on_region_id", using: :btree
  add_index "subprojects", ["user_id"], name: "index_subprojects_on_user_id", using: :btree

  create_table "table_cgdps_saa_entries", force: true do |t|
    t.integer  "cgdp_id"
    t.integer  "subproject_id"
    t.string   "saa_number"
    t.datetime "saa_date"
    t.decimal  "saa_amount",    precision: 15, scale: 2, default: 0.0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_members", force: true do |t|
    t.integer  "subproject_id"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "designation_id"
  end

  add_index "team_members", ["subproject_id"], name: "index_team_members_on_subproject_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "role_id"
    t.string   "status"
    t.integer  "region_id"
    t.integer  "municipality_id"
    t.integer  "province_id"
    t.integer  "barangay_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
