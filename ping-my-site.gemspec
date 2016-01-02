# -*- encoding: utf-8 -*-

require File.expand_path('../lib/ping-my-site/version', __FILE__)

Gem::Specification.new do |gem|  
    gem.authors       = ["Cédric Bousmanne"]
    gem.email         = ["i@cedricbousmanne.com"]
    gem.description   = %q{}
    gem.summary       = %q{A simple CLI Pingdom-like written in ruby. Check your site's HTTP status code and notify via Slack if anything went wrong.}
    gem.homepage      = "https://github.com/cedricbousmanne/PingMySite"

    gem.files         = `git ls-files`.split($\)
    gem.executables   = ["ping-my-site"]
    gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
    gem.name          = "ping-my-site"
    gem.require_paths = ["lib"]
    gem.add_runtime_dependency 'dotenv-schema', '~> 0.0.1'
    gem.add_runtime_dependency 'thor', '~> 0.19.1'
    gem.add_runtime_dependency 'curb', '~> 0.9.0'
    gem.add_runtime_dependency 'slack-notifier', '~> 1.5', '>= 1.5.1'  

    gem.add_development_dependency 'rspec'  
    gem.version       = PingMySite::VERSION
end  
