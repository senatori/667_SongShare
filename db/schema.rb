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

ActiveRecord::Schema.define(version: 20131128072633) do

  create_table "albums", force: true do |t|
    t.string   "title"
    t.date     "release_date"
    t.string   "genre"
    t.string   "credits"
    t.string   "album_artwork_url"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["artist_id"], name: "index_albums_on_artist_id", using: :btree

  create_table "appointments", force: true do |t|
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.integer  "hour"
    t.integer  "minute"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "email"
    t.string   "password_digest"
    t.string   "photo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "artists", ["email"], name: "index_artists_on_email", unique: true, using: :btree
  add_index "artists", ["remember_token"], name: "index_artists_on_remember_token", using: :btree

  create_table "fans", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followed_artists", force: true do |t|
    t.integer  "fan_id"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followed_artists", ["artist_id"], name: "index_followed_artists_on_artist_id", using: :btree
  add_index "followed_artists", ["fan_id"], name: "index_followed_artists_on_fan_id", using: :btree

  create_table "playlist_songs", force: true do |t|
    t.integer  "playlist_id"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playlist_songs", ["playlist_id"], name: "index_playlist_songs_on_playlist_id", using: :btree
  add_index "playlist_songs", ["song_id"], name: "index_playlist_songs_on_song_id", using: :btree

  create_table "playlists", force: true do |t|
    t.string   "title"
    t.integer  "fan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playlists", ["fan_id"], name: "index_playlists_on_fan_id", using: :btree

  create_table "songs", force: true do |t|
    t.string   "title"
    t.string   "featured_artists"
    t.boolean  "is_downloadable"
    t.integer  "track_number"
    t.string   "source_url"
    t.integer  "album_id"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songs", ["album_id"], name: "index_songs_on_album_id", using: :btree
  add_index "songs", ["artist_id"], name: "index_songs_on_artist_id", using: :btree

end
