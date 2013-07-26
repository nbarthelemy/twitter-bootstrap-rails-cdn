# -*- encoding: utf-8 -*-
require File.expand_path('../lib/twitter-bootstrap-rails-cdn/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nicholas Barthelemy"]
  gem.email         = ["nicholas.barthelemy@gmail.com"]
  gem.description   = %q{Twitter Boostrap CDN support for Rails 3 and 4}
  gem.summary       = %q{Twitter Boostrap CDN support for Rails 3 and 4}
  gem.homepage      = "https://github.com/nbarthelemy/twitter-bootstrap-rails-cdn"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "twitter-bootstrap-rails-cdn"
  gem.require_paths = ["lib"]
  gem.version       = TwitterBootstrap::Rails::Cdn::VERSION
  gem.license       = 'MIT'
end
