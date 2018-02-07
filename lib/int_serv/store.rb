require 'mongo'

module IntServ
  # Class to persist data with
  class Store
    extend Forwardable

    def initialize(adapter = default_adapter)
      @adapter = adapter
    end

    attr_reader :adapter
    def_delegators :adapter, :store
    def_delegators :adapter, :has_content?

    private

    def default_adapter
      IntServ::Adapters::Stores.const_get(
        store_adapter_class_name
      ).new
    end

    def store_adapter_class_name
      SETTINGS.fetch('store_adapter')
              .split('_')
              .collect!(&:capitalize)
              .join
    end
  end
end
