#!/usr/bin/env ruby

require 'sequel'
require 'fileutils'

ROOT = File.expand_path("..", __dir__)

DB_DIR = File.join(ROOT, "db")
FileUtils.mkdir_p(DB_DIR)

DB_PATH = File.join(DB_DIR, "shortener.db")

puts "[INIT] Initializing database at: #{DB_PATH}"

DB = Sequel.sqlite(DB_PATH)

unless DB.table_exists?(:urls)
  DB.create_table :urls do
    primary_key :id
    String :code, unique: true
    String :long_url, text: true
    DateTime :created_at
    Integer :clicks, default: 0
  end
  puts "[INIT] Created table :urls"
else
  puts "[INIT] Table :urls already exists, skipping."
end

puts "[INIT] Done!"
