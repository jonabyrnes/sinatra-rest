require 'mongo_mapper'

class Customer
  include MongoMapper::Document
  validates_presence_of :name
end