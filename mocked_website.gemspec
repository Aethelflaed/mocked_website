
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mocked_website/version"

Gem::Specification.new do |spec|
  spec.name          = "mocked_website"
  spec.version       = MockedWebsite::VERSION
  spec.authors       = ["Geoffroy Planquart"]
  spec.email         = ["geoffroy@planquart.fr"]

  spec.summary       = %q{Mock an entire website using webmock and sinatra}
  spec.description   = %q{Mock an entire website using webmock and sinatra}
  spec.homepage      = "https://github.com/Aethelflaed/mocked_website"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'sinatra', '~> 2.0'
  spec.add_dependency 'webmock', '~> 3.4'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
