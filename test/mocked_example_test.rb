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
    res = Net::HTTP.get_response('example.org', '/foo')

    assert Net::HTTPSuccess === res

    assert_equal 'bar', res.body
  end

  def test_other
    res = Net::HTTP.get_response('example.org', '/bar')

    assert Net::HTTPNotFound === res
  end
end
