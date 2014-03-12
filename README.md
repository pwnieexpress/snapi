# Snapi

Snapi is a modular API functionality definition tool.

## Installation

[![Gem Version](https://badge.fury.io/rb/snapi.png)](http://badge.fury.io/rb/snapi)

Install by simply typing `gem install snapi`. This has only been tested on
`1.9.3` but is should run fine on `1.9+` and `2.x+`

## Usage

#### Pending

### Snapi

#### Pending

### Functionality Disclosure

#### Pending

```ruby
Snapi[:capability]
Snapi.capabilities
Snapi.valid_capabilities
Snapi.has_capability?(:capability)
```

### Capabilities

Capabilities are core to Snapis API organizational structure. A capability
represents a collection of functions and can, for many intents and purposes, be
thought of as a kind of module.

To create a capability start with a Ruby class and include the
`Snapi::Capability` module.

```ruby
require 'snapi'

class SayHello
  include Snapi::Capability
  function :hello_world

  def self.hello_world(params)
    puts "Hello World"
  end
end
```

### Functions

#### Pending

#### Arguments

##### Pending

```ruby
fn.argument :target do |arg|
  arg.required true
  arg.list true
  arg.type :string
  arg.format :address
end
```

#### Return Type

##### Pending

    fn.return :structured

### Library Class

The `library` option on a capability can be used

```ruby
library ExternalRubyClass
```

:exclamation: *Note:* This class *must* have valid class methods with an arity
of 1 for the Capability

### Sinatra Extension

A Sinatra application can be extended with this functionality as follows.

```ruby
class MyAPi < Sinatra::Base
  register Sinatra::Namespace

  namespace "/snapi" do
    register Snapi::SinatraExtension
  end
end
```

When loaded this application will offer the following routes:

```
...
# /plugins/
# /plugins/say_hello/
# /plugins/say_hello/hello_world
...
```

## Project Goals & Name

I literally woke up in the middle of the night with the idea for a modular
Sinatra Api plugin system and wrote down the name "Snapi" which is a
contraction of "Sinatra Api". It might better be spelled "SnApi" but I prefer
"Snapi" because it snake cases to `snapi`, not `sn_api`. I like the concept of
snap-in modularity.

As of now the only real behavior is that of declaring functions and arguments
for a class as a way of doing meta-programming funcationality / arrity
disclosure.

The ultimate goal being for an API to be able to define itself dynamically and
dislose that functionality to remote systems and even do things like:

* Dynamic Form Generation
* CLI Tool / Option Parser
* Self Documentation

