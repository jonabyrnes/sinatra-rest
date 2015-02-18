require './spec/spec_helper'
require './server'
require 'rack/test'

describe 'assets' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should be able to return the index page' do
    get '/'
    expect(last_response.header['Content-Type']).to include('html')
    expect(last_response.status).to eq(200)
  end

  it 'should be able to return the angular app' do
    get '/js/app.js'
    expect(last_response.status).to eq(200)
    expect(last_response.header['Content-Type']).to include('javascript')
  end

end