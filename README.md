# MockedWebsite

Simple gem using WebMock and sinatra to easily mock a website

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mocked_website'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mocked_website

## Usage

```ruby
MockedGitlab = MockedWebsite.create('https://git.example.org/api/v4') do
  cattr_accessor(:projects) do
    Hash.new{|h, k| h[k] = {name: k}}
  end
  cattr_accessor(:issues) do
    Hash.new{|h, k| h[k] = {id: k}}
  end

  get '/projects/:group_name/:project_name/issues/:id' do
    issues[params[:id].to_i].to_json
  end

  get '/projects/*' do |name|
    projects[name].to_json
  end
end

# Elsewhere
class MyTest < ActiveSupport::TestCase
  setup do
    MockedGitlab.setup
  end
  
  # test the behavior of your app against what you predefine in MockedGitlab
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Aethelflaed/mocked_website.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
