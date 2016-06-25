require 'mongo'

module IntServ
  # Class to persist data with
  class Store
    attr_reader :client
    def initialize
      @client = Mongo::Client.new(SETTINGS['mongodb_uri'])
    end

    def store(data)
      client[:messages].insert_one(data)
    end
  end
end
