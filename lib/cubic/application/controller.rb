module Cubic
  # All classes generated by Cubic inherit from CubicController
  class CubicController
    extend Logable

    class << self
      attr_accessor :namespace
  
      # Allows for namespacing within controllers who inherit
      # from CubicController
      def namespace(name, &b)
        @namespace = name
        b.call
      ensure
        @namespace = nil
      end

      def get(url, &block)
        namespace_url(url) if @namespace
        url = format_url(url)
        route_setter('GET', url, block)
      end

      def post(url, &block)
        namespace_url(url) if @namespace
        route_setter('POST', url, block)
      end

      def put(url, &block)
        namespace_url(url) if @namespace
        route_setter('PUT', url, block)
      end

      def delete(url, &block)
        namespace_url(url) if @namespace
        route_setter('DELETE', url, block)
      end

      def route_setter(request_method, url, block)
        Router.set_route(request_method, url, block)
      end

      def format_url(url)
        if url.is_a?(String) && url[0] != '/'
          url.prepend('/')
        else
          url
        end
      end

      def namespace_url(url)
        url.prepend(@namespace + '/')
      end
    end
  end
end
