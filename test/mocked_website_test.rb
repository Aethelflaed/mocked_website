require "test_helper"

class MockedWebsiteTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MockedWebsite::VERSION
  end

  def test_respond_to_setup_and_teardown
    app = MockedWebsite.create('http://example.org') do
      # ...
    end

    assert app.respond_to?(:setup)
    assert app.respond_to?(:teardown)

    app = MockedWebsite.create('http://example.org') do
      def self.teardown
        :foo
      end
    end

    assert app.respond_to?(:setup)
    assert app.respond_to?(:teardown)
    assert_equal :foo, app.teardown
  end

  def test_pattern
    app = MockedWebsite.create('http://example.org') do
    end

    assert_equal(/^#{Regexp.escape('http://example.org')}/, app.instance_variable_get('@pattern'))

    app = MockedWebsite.create('http://example.org/foo') do
    end

    assert_equal(/^#{Regexp.escape('http://example.org/foo')}/, app.instance_variable_get('@pattern'))
  end

  def test_rack_app
    app = MockedWebsite.create('http://example.org') do
    end

    rack_app = app.instance_variable_get('@rack_app')
    assert rack_app.is_a?(Class)
    assert rack_app.ancestors.include?(Sinatra::Base)

    app = MockedWebsite.create('http://example.org/foo') do
    end

    rack_app = app.instance_variable_get('@rack_app')
    assert Rack::URLMap === rack_app
  end
end
