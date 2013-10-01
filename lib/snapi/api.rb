module Snapi
  class Api
    include Capability
    # This method is not intended to be used on inherrited classes,
    # but rather on the Capability class itself as a way of building
    # a collection of all the subclasses which inherrit from it. This
    # allows for a handy way to grab all the capabilities of a system
    # and easily map out a (simple) API
    #
    # TODO This does **not** currently support nested namespaces or route
    # spaces and that may or may not present a challenge in the future
    #
    # @returns Hash of all Capability subclasses converted to their hash representation
    def self.full_hash
      self.subclasses.inject({}) do |collector, klass|
        collector.merge(klass.to_hash)
      end
    end
  end
end
