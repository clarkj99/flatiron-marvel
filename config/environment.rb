require "bundler/setup"
require "rest_client"
require "digest"
require "json"
require_relative "../.config.rb"

Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "./db/marvel.sqlite3",
)
#Set to control SQL logging to console
ActiveRecord::Base.logger = nil

require_all "app"
