module IntServ
  module Adapters
    module Stores
      # Adapter to store data in ruby array (used for testing)
      class InMem < ::IntServ::Adapters::Store
        extend Forwardable

        def initialize
          @array = Thread.current[:memstore] ||= []
        end

        def_delegators :@array, :<<
        def_delegators :@array, :include?
        alias store <<
      end
    end
  end
end
