require 'rubillow'

Rubillow.configure do |configuration|
  configuration.zwsid = ENV["ZILLOW_ZWSID"]
end
