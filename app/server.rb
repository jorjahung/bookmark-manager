require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash
set :partial_template_engine, :erb

# models before data_mapper_setup:
require_relative 'models/link'
require_relative 'models/tag'
require_relative 'models/user'

# controllers:
require_relative 'controllers/application'
require_relative 'controllers/links'
require_relative 'controllers/sessions'
require_relative 'controllers/tags'
require_relative 'controllers/users'

require_relative 'helpers/application'
require_relative 'data_mapper_setup'




