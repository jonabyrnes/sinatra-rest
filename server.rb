require 'sinatra'
require 'sinatra/activerecord'
require 'json'

class Customer < ActiveRecord::Base
end

get '/customers.json' do
  content_type :json
  Customer.all.to_json
end

post '/customers.json' do
  @customer = Customer.new(params)
  @customer.save
end
