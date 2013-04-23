module Padrino
  class Application
    
    class << self
      
      include Restpie::ControllerExtensions
      
      # Required for setting description at method level in padrino
      def description(*args)
        #do nothing
      end
      
      def put_with_restpie_annotations(path, opts={}, &block)
        route = put_without_restpie_annotations(path, opts, &block)
        add_method_to_resource("PUT", route.original_path, path, opts)
      end
      
      def post_with_restpie_annotations(path, opts={}, &block)
        route = post_without_restpie_annotations(path, opts, &block)
        add_method_to_resource("POST", route.original_path, path, opts)
      end
      
      def delete_with_restpie_annotations(path, opts={}, &block)
        route = delete_without_restpie_annotations(path, opts, &block)
        add_method_to_resource("DELETE", route.original_path, path, opts)
      end
      
      def head_with_restpie_annotations(path, opts={}, &block)
        route = head_without_restpie_annotations(path, opts, &block)
        add_method_to_resource("HEAD", route.original_path, path, opts)
      end
      
      def options_with_restpie_annotations(path, opts={}, &block)
        route = options_without_restpie_annotations(path, opts, &block)
        add_method_to_resource("OPTIONS", path, opts)
      end
      
      def patch_with_restpie_annotations(path, opts={}, &block)
        route = patch_without_restpie_annotations(path, opts, &block)
        add_method_to_resource("PATCH", route.original_path, path, opts)
      end
      
      def get_with_restpie_annotations(path, opts={}, &block)
        route = get_without_restpie_annotations(path, opts, &block)
        add_method_to_resource("GET", route.original_path, path, opts)
      end
      
      def controllers_with_restpie_annotations(*args, &block)
        options = {}
        path = "/"
        unless args.empty?
          if args[0].kind_of?(Hash)
            options = args[0]
          else
            path = derive_path(args[0])
          end
          options = args[1] if args[1]
        end
        name = path == "/" ? "Root" : path.delete("/")
        Restpie::API.add_resource(self.name, Restpie::API::Resource.new(name, options))
        controllers_without_restpie_annotations(*args, &block)
      end
      
      alias_method_chain :controllers, :restpie_annotations
      
      alias_method_chain :put, :restpie_annotations
      alias_method_chain :post, :restpie_annotations
      alias_method_chain :get, :restpie_annotations
      alias_method_chain :delete, :restpie_annotations
      alias_method_chain :head, :restpie_annotations
      alias_method_chain :patch, :restpie_annotations
      alias_method_chain :options, :restpie_annotations
      
      private
      def derive_path(path)
        path.kind_of?(Symbol) || !path.start_with?('/') ? "/#{path}" : path 
      end
      
      def add_method_to_resource(method, original_path, local_path, opts)
        return unless Restpie::API.applications[self.name]
        resource = Restpie::API.applications[self.name][:resources].values.last
        restpie_api_info[:formats] = opts[:provides] || @_provides
        restpie_api_info[:short_description] = opts[:description]
        restpie_api_info[:method] = method
        restpie_api_info[:path] = original_path
        restpie_api_info[:local_path] = local_path
        resource.add_method(restpie_api_info)
        clear_restpie_api_info
      end
      
    end
  end
end