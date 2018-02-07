module IntServ
  module Adapters
    # Base of store adapters
    class Store
      def store(_data)
        raise NotImplementedError
      end

      def include?(_arg)
        raise NotImplementedError, 'Intended for use in tests. Not required'
      end
    end
  end
end
