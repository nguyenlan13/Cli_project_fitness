require 'pry'
require 'nokogiri'
require 'open-uri'
require 'colorize'


module Fitness
  class Error < StandardError; end
  # Your code goes here...
end

require_relative "./fitness/version"
require_relative './group_fitness'
require_relative './gyms'
require_relative './scraper'
require_relative './cli'
