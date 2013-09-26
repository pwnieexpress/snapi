module Snapi
  class Capability

    @@routes = {}

    def self.route(path, meta_info={})
      @@routes[path.to_s] = meta_info
    end

    def self.routes
      @@routes
    end

    # Convert the class name to  a snake-cased
    # URL friendly namespace
    def namespace
      self.class.name
                .split('::').last
                .scan(/([A-Z]+[a-z0-9]+)/)
                .flatten.map(&:downcase)
                .join("_")
    end

  end
end
