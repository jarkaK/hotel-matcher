# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hotel_matcher/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name    = 'hotel-matcher'
  gem.version = HotelMatcher::VERSION
  gem.summary = 'Searching urls of hotels on multiple sites'
  gem.description = "extended description"

  gem.authors  = ['Jaroslava Kadlecova']
  gem.email    = 'kadlecovaj@gmail.com'
  gem.homepage = 'http://github.com/jarkadlec/hotel-matcher'

  gem.executables   = ["hotel-matcher"]

  gem.required_ruby_version = '>= 2.0'
  gem.add_dependency('httparty', '~> 0.13')
  gem.add_dependency('nokogiri', '~> 1.6')

  gem.add_development_dependency('rspec', '~> 3.3')
  gem.add_development_dependency 'bundler', '~> 1.0'
end
