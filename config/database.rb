require 'sequel'
require 'fileutils'

DB_DIR = File.expand_path('../db', __dir__)
FileUtils.mkdir_p(DB_DIR)

DB_PATH = File.join(DB_DIR, ENV.fetch('SHORTENER_DB', 'shortener.db'))

DB = Sequel.sqlite(DB_PATH)

if DB.table_exists?(:urls)
  URLS = DB[:urls]
else
  warn '[WARNING] Table :urls does not exist. You must run: ruby scripts/init_db.rb'
  URLS = nil
end
