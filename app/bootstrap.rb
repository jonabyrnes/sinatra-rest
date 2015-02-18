# generic file loader
def requireFiles(path)
  Dir[path].each do |file|
    require Dir.pwd + '/' + file
  end
end

requireFiles 'app/initializers/*.rb'     # misc initializers
requireFiles 'app/error/*.rb'       # load custom exceptions
requireFiles 'app/helpers/*.rb'     # load helpers
requireFiles 'app/models/*.rb'      # load models
requireFiles 'app/controllers/*.rb' # load controllers
requireFiles 'app/assets/*.rb'      # defer static files to last
