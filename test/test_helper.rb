$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'webmock/minitest'
require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
end

require "mocked_website"

require "minitest/autorun"
