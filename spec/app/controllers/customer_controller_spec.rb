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
    expect(last_response.status).to eq(200)
  end

  it 'should create a new customer' do
    post '/customers.json', {:name => 'Test Customer', :address => 'New York'}.to_json
    expect(last_response.header['Location']).not_to be_falsey
    expect(last_response.status).to eq(201)
  end

  it 'should load a customer by id' do
    # create and get a customer
    post '/customers.json', {:name => 'Test Customer', :address => 'New York'}.to_json
    expect(last_response.status).to eq(201)
    get last_response.header['Location']
    expect(last_response.status).to eq(200)
  end

  it 'should delete a customer by id' do
    # create and delete a customer
    post '/customers.json', {:name => 'Test Customer', :address => 'New York'}.to_json
    expect(last_response.status).to eq(201)
    delete last_response.header['Location']
    expect(last_response.status).to eq(200)
  end

  it 'should reject a customer with no name' do
    post '/customers.json', {:name => nil, :address => 'New York'}.to_json
    expect(last_response.status).to eq(400)
  end

  it 'should report not found if updating a customer that does not exist' do
    put '/customers/0.json', {:address => 'A new address'}.to_json
    expect(last_response.status).to eq(404)
  end

  it 'should be able to update an existing customer' do
    post '/customers.json', {:name => 'Test Customer', :address => 'Old Address'}.to_json
    expect(last_response.status).to eq(201)
    put last_response.header['Location'], {:address => 'New Address'}.to_json
    expect(last_response.status).to eq(200)
  end

end