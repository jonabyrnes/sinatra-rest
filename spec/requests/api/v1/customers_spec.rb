require './spec/spec_helper'
require './server'
require 'rack/test'

describe 'customers api' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should return a list of all customers' do
    get '/customers.json'
    puts last_response.body
    expect(last_response.status).to eq(200)
  end

  it 'should create a new customer' do
    post '/customers.json', {:name => 'Test Customer', :address => 'New York'}
    puts last_response.body
    expect(last_response.status).to eq(200)
  end

  it 'should load a customer by id' do
    get '/customers/1.json'
    puts last_response.body
    expect(last_response.status).to eq(200)
  end

end