require 'httparty'
require 'logger'
require 'nokogiri'

# TODO: support configuration of logger from other applications, support different levels for environments
LOGGER = Logger.new('hotel-matcher.log')
LOGGER.level = Logger::INFO

require_relative '../lib/hotel_matcher/bulk.rb'
require_relative '../lib/hotel_matcher/parser/base.rb'
require_relative '../lib/hotel_matcher/parser/booking.rb'
require_relative '../lib/hotel_matcher/parser/holidaycheck.rb'
require_relative '../lib/hotel_matcher/parser/tripadvisor.rb'
require_relative '../lib/hotel_matcher/version.rb'
