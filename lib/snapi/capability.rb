module Snapi
  class Capability

    @@routes = {}

    def self.route(path, meta_info={})
      @@routes[path.to_s] = meta_info
      yield(path) if block_given?
    end

    def self.parameter(path, name, meta_info={})
      @@routes[path][name] = meta_info
    end

    def self.returned_type(path, type)
      @@routes[path]["returned_type"] = type
    end

    def self.routes
      @@routes
    end

    # Convert the class name to  a snake-cased
    # URL friendly namespace
    def self.namespace
      self.name
          .split('::').last
          .scan(/([A-Z]+[a-z0-9]+)/)
          .flatten.map(&:downcase)
          .join("_")
    end

    def self.to_hash
      {
        self.namespace => @@routes
      }
    end

    def self.full_hash
      self.subclasses.inject({}) do |collector, klass|
        collector.merge(klass.to_hash)
      end
    end
  end
end
