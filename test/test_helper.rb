$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
end

require 'minitest'
require 'webmock/minitest'

require "mocked_website"

require "minitest/autorun"
