# -*- encoding: utf-8 -*-
require File.expand_path('../lib/restpie/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["ganeshs"]
  gem.email         = ["ganeshs@flipkart.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "restpie"
  gem.require_paths = ["lib", "app"]
  gem.version       = Restpie::VERSION
end
