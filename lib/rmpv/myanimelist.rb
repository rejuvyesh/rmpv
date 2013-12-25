#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# File: myanimelist.rb
#
# Copyright rejuvyesh <mail@rejuvyesh.com>, 2013

require "yaml"
require "myanimelist"

module Rmpv
  class Myanimelist

    ##
    # Initialize the Myanimelist client

    def initialize
      myanimeconfig = YAML.load File.open('#{Dir.home}/.rmpvrc')
    end

    def scrobble show
      tries = 5
      begin
        
      rescue Exception => e
        tries -= 1
        if tries > 0
          retry
        else
          puts "Couldn't connect to Myanimelist servers: #{e}"
        end
      end
    end
  end
end
