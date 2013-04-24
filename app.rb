require 'bundler'
Bundler.require
require 'sinatra'
require 'json'
require 'net/http'
require "uri"
require "./lib/sseapi.rb"
require "./lib/mapjs.rb"

set :protection, except: :ip_spoofing

get '/' do
  
  @title = "SSE Power outages"
  @data = SSEapi.data
  erb :index

end

get '/rss/?' do
  
  @data = SSEapi.data
  builder :rss_all
  
end

get '/map/?' do

  @title = "SSE Power outages"
  @mapjs = "#{request.url.chomp request.path_info}/javascript/all_alerts.js"
  erb :google_map, :layout => false
  #erb :index
  
end

get '/javascript/all_alerts.js' do
  
  Mapsjs.alerts
  
end

not_found do  
  status 404  
  '404 not found'  
end
