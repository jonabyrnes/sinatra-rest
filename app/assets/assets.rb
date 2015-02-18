# special case for the root
get '/' do
  File.read('app/assets/index.html')
end

# and all other static content
get '/*.*' do
  parts = params[:splat]
  if( parts[1] == 'js'); content_type :js end
  File.read("app/assets/#{parts[0]}.#{parts[1]}")
end

