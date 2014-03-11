# Snapi

[![Gem Version](https://badge.fury.io/rb/snapi.png)](http://badge.fury.io/rb/snapi)

Snapi is a modular API functionality definition tool.


## Installation

This hasn't been put on Rubygems yet so you still have to build the gem
manually for now. 

```sh
git clone git@github.com:pwnieexpress/snapi.git
cd snapi
gem build snapi.gemspec
gem install snapi
```
This has only been used on `1.9.3` but is should run fine on `1.9+` and `2.x+`

## Usage

Simple Example:

```ruby
require 'snapi'
require 'json'

class ScannerLibrary
  def self.scan(args)
    #                                  
    #  _| _    _|_|_  _    _|_|_  o __  _ 
    # (_|(_)    |_| |(/_    |_| | | | |(_|
    #                                  __|
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
```

## Sinatra Extension

A Sinatra application can be extended with this functionality as follows.

```ruby
class MyAPi < Sinatra::Base
  register Sinatra::Namespace

  namespace Snapi.capability_root do
    register Snapi::SinatraExtension
  end
end
```

When loaded this application will offer the following routes:

```
# /plugins/
# /plugins/scanner/
# /plugins/scanner/scan/
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
* API generation (TODO `snapi generate hosts plugin:crud`)
* Self Documentation
