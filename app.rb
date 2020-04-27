require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'

set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

require_relative 'cookbook'
require_relative 'recipe'
require_relative 'importer'

get '/' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

get '/import' do
  erb :import
end

post '/queries' do
  @import = Importer.new(params[:keyword])
  @search_results = @import.import
  erb :queries
end



post '/recipes' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  recipe = Recipe.new(params[:name], params[:description], params[:prep_time],
  params[:difficulty])
  cookbook.add_recipe(recipe)
  redirect '/'
end

get '/recipes/:index' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  cookbook.remove_recipe(params[:index].to_i)
  redirect '/'
end

get '/about' do
  erb :about
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end

# binding.pry to check things
