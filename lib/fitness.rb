require 'pry'
require 'nokogiri'
require 'open-uri'
require 'colorize'
require 'httparty'
require 'json'




module Fitness
  class Error < StandardError; end
  # Your code goes here...
end

require_relative "./fitness/version"
require_relative './fitness/group_fitness'
require_relative './fitness//gym_location'
require_relative './fitness/scraper'
require_relative './fitness/cli'
