# encoding: UTF-8
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
# More require statements...

require_relative 'models/user'
require_relative 'models/problem'
require_relative 'models/solution'
# encoding: UTF-8require_relative 'models/solution_test'
require_relative 'routes/home'
require_relative 'routes/users'
require_relative 'routes/problem'
require_relative 'routes/solution'

set :database, {adapter: "sqlite3", database: "public/foo.sqlite3"}

enable :sessions

before do
  @user = User.where(id: session[:user_id]).first
end