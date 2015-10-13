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

ActiveRecord::Schema.define(version: 20151013032040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auction_admins", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "auction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "auction_admins", ["auction_id"], name: "index_auction_admins_on_auction_id", using: :btree
  add_index "auction_admins", ["user_id"], name: "index_auction_admins_on_user_id", using: :btree

  create_table "auctions", force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "time_zone_id"
    t.text     "physical_address"
    t.string   "name"
    t.datetime "donation_window_ends_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "organization_id",         null: false
  end

  add_index "auctions", ["organization_id"], name: "index_auctions_on_organization_id", using: :btree

  create_table "bid_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bid_types", ["name"], name: "index_bid_types_on_name", unique: true, using: :btree

  create_table "bids", force: :cascade do |t|
    t.integer  "donation_id",    null: false
    t.integer  "bidder_id",      null: false
    t.integer  "amount_dollars", null: false
    t.integer  "quantity",       null: false
    t.datetime "placed_at",      null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "bids", ["bidder_id"], name: "index_bids_on_bidder_id", using: :btree
  add_index "bids", ["donation_id"], name: "index_bids_on_donation_id", using: :btree

  create_table "donation_categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "donation_categories", ["name"], name: "index_donation_categories_on_name", unique: true, using: :btree

  create_table "donations", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "quantity"
    t.integer  "auction_id",                                  null: false
    t.integer  "bid_type_id"
    t.integer  "donor_id",                                    null: false
    t.datetime "redemption_window_starts_at"
    t.datetime "redemption_window_ends_at"
    t.integer  "estimated_value_amount"
    t.integer  "minimum_bid_amount"
    t.text     "display_description"
    t.boolean  "admin_follow_up_needed",      default: false
    t.integer  "fulfillment_type"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "donations", ["auction_id"], name: "index_donations_on_auction_id", using: :btree
  add_index "donations", ["bid_type_id"], name: "index_donations_on_bid_type_id", using: :btree
  add_index "donations", ["donor_id"], name: "index_donations_on_donor_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id",         null: false
    t.integer  "organization_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "memberships", ["organization_id"], name: "index_memberships_on_organization_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                null: false
    t.string   "mobile_phone_number", null: false
    t.string   "email_address",       null: false
    t.string   "physical_address",    null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "password_digest",     null: false
  end

  add_index "users", ["email_address"], name: "index_users_on_email_address", unique: true, using: :btree
  add_index "users", ["mobile_phone_number"], name: "index_users_on_mobile_phone_number", unique: true, using: :btree

  add_foreign_key "auction_admins", "auctions"
  add_foreign_key "auction_admins", "users"
  add_foreign_key "auctions", "organizations"
  add_foreign_key "bids", "donations"
  add_foreign_key "bids", "users", column: "bidder_id"
  add_foreign_key "donations", "auctions"
  add_foreign_key "donations", "bid_types"
  add_foreign_key "donations", "users", column: "donor_id"
  add_foreign_key "memberships", "organizations"
  add_foreign_key "memberships", "users"
end
