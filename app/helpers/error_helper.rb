# disable the default error handler
set :show_exceptions, false

# global error handler
# TODO : handle standard error codes, 401, 404, etc
# TODO : wrap active record errors so layer can be replaced
error do
  e = env['sinatra.error']
  content_type :json
  if e.is_a?(ValidationError); status 400 end
  if e.is_a?(NotFoundError); status 404 end
  {:result => 'error', :message => e.message}.to_json
end