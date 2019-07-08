# frozen_string_literal: true

# Top level namespace fot this service, require me and you should have everthing
module IntServ
  require 'int_serv/exceptions'
  require 'int_serv/store'
  require 'int_serv/workers/service'
  require 'int_serv/adapters/stores/mongodb'
  require 'int_serv/adapters/stores/in_mem'
end
