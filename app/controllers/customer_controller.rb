get '/customers.json' do
  content_type :json
  Customer.all.to_json
end

get '/customers/:id.json' do
  content_type :json
  @customer = Customer.find(params[:id])
  @customer.to_json
end

post '/customers.json' do
  params = JSON.parse(request.body.string)
  @customer = Customer.new(params)
  @customer.save!
  headers 'Location' => "/customers/#{@customer.id}.json"
  status 201
end

put '/customers/:id.json' do
  @customer = Customer.find(params[:id])
  params = JSON.parse(request.body.string)
  @customer.update!(params)
end

delete '/customers/:id.json' do
  @customer = Customer.find(params[:id])
  @customer.destroy
end