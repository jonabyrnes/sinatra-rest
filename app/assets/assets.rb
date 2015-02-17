# TODO: more dynamic way to serve static files
get '/' do
    File.read(File.join('app', 'assets/index.html'))
end

get '/app.js' do
    content_type :js
    File.read(File.join('app', 'assets/javascripts/app.js'))
end