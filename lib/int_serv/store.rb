require 'mongo'

module IntServ
  class Store
    attr_reader :client
    def initialize
      @client = Mongo::Client.new(SETTINGS['mongodb_uri'])
    end
  
    def store(data)
      result = client[:messages].insert_one(data)
    end
  end
end
