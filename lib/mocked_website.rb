# frozen_string_literal: true

require "mocked_website/version"
require 'webmock'
require 'sinatra'

module MockedWebsite
  def self.create(uri, &block)
    uri = URI(uri)
    pattern = /^#{Regexp.escape(uri.to_s)}/

    rack_app = app = Class.new(Sinatra::Base, &block)

    # So you don't have to type that e.g. /api/v4 for each path
    if !uri.path.empty? && uri.path != '/'
      rack_app = Rack::URLMap.new(uri.path => app)
    end

    app.instance_variable_set('@pattern', pattern)
    app.instance_variable_set('@rack_app', rack_app)

    def app.setup
      WebMock::API.stub_request(:any, @pattern).to_rack(@rack_app)
    end

    # Only define teardown if it doesn't already exist,
    # helps to provide a common API
    if !app.respond_to?(:teardown)
      def app.teardown
      end
    end

    return app
  end
end
