require 'freddie/routing'
require 'freddie/actions'
require 'freddie/rackable'

module Freddie
  class Application
    include Routing
    include Actions
    include Rackable

    attr_reader :options

    def initialize(delegate_app = nil, options = {})
      @delegate_app = delegate_app
      @options = options
    end

    def request
      local_or_delegate(:request)
    end

    def response
      local_or_delegate(:response)
    end

    def remaining_path
      local_or_delegate(:remaining_path)
    end

    def method_missing(name, *args, &blk)
      @delegate_app.try(name, *args, &blk) || super
    end

    def local_or_delegate(name)
      instance_variable_get("@#{name}") || @delegate_app.send(name)
    end

    def params
      request.params
    end

    def handle_request
      # implement this in a subclass
    end
  end
end