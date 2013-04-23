module Restpie
  module API
    
    @@applications = {}
    
    class << self
      def applications
        @@applications
      end
      
      def add_resource(application, resource)
        unless @@applications[application]
          @@applications[application] = {:name => application, :resources => {}}
        end
        @@applications[application][:resources][resource.name] = resource
      end
    end
    
    class Resource
      
      attr_reader :name, :methods, :description, :formats
      
      def initialize(name, path, options={})
        @name = name
        @description = options[:description]
        @formats = options[:formats] || []
        @methods = options[:methods] || {}
      end
      
      def add_method(method_options)
        api = Api.new(method_options[:method], method_options[:path], method_options[:short_description])
        @methods[method_options[:local_path]] = Method.new(api, method_options)
      end
    end
    
    class Api
      
      attr_reader :method, :path, :description
      
      def initialize(method, path, description)
        @method = method
        @path = path
        @description = description
      end
      
      def to_s
        "#{method.upcase} #{path}"
      end
      
    end
    
    class Param
      
      attr_reader :name, :description, :required, :allow_nil, :validator
    
      def initialize(name, options={})
        @name = name
        @description = options[:description]
        @required = options[:required] || false
        @allow_nil = options[:allow_nil] || true
        @validator = options[:validator]
      end
      
    end
    
    class Method
      attr_reader :api, :description, :params, :formats, :request_schema, :response_schema, :codes, :local_path
    
      def initialize(api, options={})
        @api = api
        @description = options[:description]
        @params = options[:params] || []
        @formats = options[:formats] || []
        @codes = options[:codes] || []
        @request_schema = options[:request_schema]
        @response_schema = options[:response_schema]
        @local_path = options[:local_path]
      end
      
      def add_param(param)
        @params << param
      end
      
      def add_code(code)
        @codes << code
      end
    end
    
    class ResponseCode
      attr_reader :code, :description
      
      def initialize(code, description)
        @code = code
        @description = description
      end
    end
  end
end