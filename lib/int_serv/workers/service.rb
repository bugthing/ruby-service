
require 'sneakers'
require 'json'

module IntServ
  module Workers
    # Sample service class to parse message and store json
    class Service
      include Sneakers::Worker
      from_queue 'events'

      def work(message)
        json = parse_message(message)
        store_json(json)
        ack!
      end

      private

      def store_json(json)
        store.store(json)
      end

      def store
        IntServ::Store.new
      end

      def parse_message(message)
        return JSON.parse(message)
      rescue TypeError, JSON::ParserError => e
        raise IntServ::Exceptions::JsonParseError, e
      end
    end
  end
end
