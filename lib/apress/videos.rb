# coding: utf-8
require 'rails'
require 'active_hash'
require 'apress/api'
require 'apress/videos/version'
require 'draper'
require 'haml'
require 'resque/integration'
require 'strong_parameters' if ::Rails::VERSION::MAJOR < 4
require 'apress/videos/engine'

module Apress
  module Videos
  end
end
