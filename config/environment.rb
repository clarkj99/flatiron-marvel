require "bundler/setup"
require "rest_client"
require "digest"
require "json"
require_relative "../.config.rb"

# Make sure to create "/.config.rb" file with contents:
#  CONFIG = {
#   my_key: "public_api",
#   secret_key: "private_api"
# }

Bundler.require

# class ApplicationRecord < ActiveRecord::Base
#   self.abstract_class = true
# end

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "./db/marvel.sqlite3",
)
#Set to  0 or 1 to control SQL logging to console
# ActiveRecord::Base.logger.level = 1

require_all "app"
