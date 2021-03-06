# Remember environment variables from week 1?
ENV["RACK_ENV"] = 'test' # because we need to know what database to work with
require './app/server' 
require 'database_cleaner'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.app = Sinatra::Application
Capybara.javascript_driver = :poltergeist

# this needs to be after ENV["RACK_ENV"] = 'test' 
# because the server needs to know what environment it's running it: test or development. 
# The environment determines what database to use.


RSpec.configure do |config|

 	config.treat_symbols_as_metadata_keys_with_true_values = true
 	config.run_all_when_everything_filtered = true
 	config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

 config.before(:suite) do    
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction    
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end