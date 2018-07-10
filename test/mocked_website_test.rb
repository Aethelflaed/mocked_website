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
  end
end
