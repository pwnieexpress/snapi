# The core Hash class
# This adds the deep_merge method to this core class which is used to join nested hashes
class Hash

  # Non destructive version of deep_merge using a dup
  #
  # @param [Hash] the hash to be merged with
  # @returns [Hash] A copy of a new hash merging the hash
  # this was called on and the param hash
  def deep_merge(other_hash)
    dup.deep_merge!(other_hash)
  end

  # Recusively merges hashes into each other. Any value that is not a Hash will
  # be overridden with the value in the other hash.
  #
  # @param [Hash] the hash to be merged with
  # @returns [Hash] A copy of itself with the new hash merged in
  def deep_merge!(other)
    raise ArgumentError unless other.is_a?(Hash)

    other.each do |k, v|
      self[k] = (self[k].is_a?(Hash) && self[k].is_a?(Hash)) ? self[k].deep_merge(v) : v
    end

    self
  end

end

