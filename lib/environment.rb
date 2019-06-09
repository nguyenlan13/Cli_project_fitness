require 'pry'
require 'nokogiri'
require 'open-uri'



module Fitness
  class Error < StandardError; end
  # Your code goes here...
end

require_relative "./fitness/version"
require_relative './fitness_classes'
require_relative './cli'
require_relative './scraper'