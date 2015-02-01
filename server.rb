require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
# More require statements...

require_relative 'models/user'
require_relative 'models/problem'
require_relative 'models/solution'
require_relative 'routes/home'
require_relative 'routes/users'

set :database, {adapter: "sqlite3", database: "public/foo.sqlite3"}

enable :sessions

before do
  @user = User.find_by_id(session[:user_id])
end