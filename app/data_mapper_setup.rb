require 'data_mapper'
require_relative 'server.rb'

env = ENV["RACK_ENV"] || "development"
		# we're telling datamapper to use a postgres database on localhost. 
		# The name will be "bookmark_manager_test" or "bookmark_manager_development" depending 
		# on the environment
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

Dir.glob(File.join(File.dirname(__FILE__), 'models', '*.rb'), &method(:require))

		# After declaring your models, you should finalise them:
DataMapper.finalize
		# However, our database tables don't exist yet. Let's tell datamapper to create them:
DataMapper.auto_upgrade!

