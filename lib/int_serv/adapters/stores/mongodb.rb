# frozen_string_literal: true

require_relative '../store'
module IntServ
  module Adapters
    module Stores
      # Adapter to store data in mongodb
      class Mongodb < ::IntServ::Adapters::Store
        def initialize
          @client = Mongo::Client.new(SETTINGS['mongodb_uri'])
        end

        def store(data)
          client[:messages].insert_one(data)
        end

        private

        attr_reader :client
      end
    end
  end
end
