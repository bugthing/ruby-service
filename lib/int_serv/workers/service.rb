require 'sneakers'
require 'json'

module IntServ
  module Workers
    class Service
      include Sneakers::Worker
      from_queue 'events'
    
      def work(message)
        ##logger.log "WORKER RECEIVED: #{message}"
    	json = parse_message(message)
    	store_json(json)
        ack!
      end
    
      private
    
      def store_json(json)
        IntServ::Store.new.store(json)
      end
    
      def parse_message(message)
    	return JSON.parse(message)
      rescue TypeError => e
        fail IntServ::Exceptions::JsonParseError, e
      end
    end
  end
end
