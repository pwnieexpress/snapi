require 'snapi'
require 'json'

class ScannerLibrary
  def self.scan(args)
    # ...
  end
end

class Scanner

  include Snapi::Capability

  function :scan do |fn|
    fn.argument :target do |arg|
      arg.required true
      arg.list true
      arg.type :string
      arg.format :address
    end
    fn.argument :port do |arg|
      arg.type :string
    end
    fn.return :structured
  end

  library ScannerLibrary

end

puts "Functions:"
puts
puts JSON.pretty_generate Scanner.functions
puts
puts "Library: #{Scanner.library_class}"
puts "Valid?:  #{Scanner.valid_library_class?.to_s.capitalize}"
puts
puts "Snapi Capabilities:"
puts
puts Snapi.capabilities
