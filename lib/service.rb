require 'sneakers'
require 'json'
require 'store'

class Service
  include Sneakers::Worker
  from_queue 'events'

  def work(message)
    puts "WORKER RECEIVED: #{message}"
    option = JSON.parse(message)
    Store.new.store(option)
    ack!
  end
end
