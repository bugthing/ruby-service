require 'mongo'

class Store
  attr_reader :client
  def initialize
    @client = Mongo::Client.new(SETTINGS['mongodb_uri'])
  end

  def store(data)
    result = client[:messages].insert_one(data)
	puts "STORE STORED: #{result}"
  end
end
