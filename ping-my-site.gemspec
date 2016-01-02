# -*- encoding: utf-8 -*-

require File.expand_path('../lib/ping-my-site/version', __FILE__)

Gem::Specification.new do |gem|  
    gem.authors       = ["Cédric Bousmanne"]
    gem.email         = ["i@cedricbousmanne.com"]
    gem.description   = %q{}
    gem.summary       = %q{}
    gem.homepage      = "http://cedric.io"

    gem.files         = `git ls-files`.split($\)
    gem.executables   = ["ping-my-site"]
    gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
    gem.name          = "ping-my-site"
    gem.require_paths = ["lib"]
    gem.version       = PingMySite::VERSION
end  
