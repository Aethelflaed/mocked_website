require 'test_helper'

require 'net/http'

MockedExample = MockedWebsite.create('http://example.org') do
  get '/foo' do
    'bar'
  end
end

class MockedExampleTest < Minitest::Test
  def setup
    super
    MockedExample.setup
  end

  def test_foo
    uri = URI('http://example.org/foo')
    res = Net::HTTP.get_response(uri)

    assert Net::HTTPSuccess === res

    assert_equal 'bar', res.body
  end

  def test_other
    uri = URI('http://example.org/bar')
    res = Net::HTTP.get_response(uri)

    assert Net::HTTPNotFound === res
  end
end
