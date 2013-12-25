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

    def initialize file
      myanimeconfig = YAML.load File.open("#{Dir.home}/.rmpvrc")
      MyAnimeList.configure do |config|
        config.username = myanimeconfig["myanimelist"]["username"]
        config.password = myanimeconfig["myanimelist"]["password"]
      end
    end

    def parse file
      raw_name = file
      raw_name = raw_name[0, raw_name.rindex(/\./)] # remove extension
      raw_name = raw_name.gsub(/(\.|_|\-)/, '')  #Chars used in filenames as a substitute for spaces
      raw_name = raw_name.gsub(/\(.*?\)/, '') # Remove anything surrounded by paranthesis
      raw_name = raw_name.gsub(/\[.*?\]/, '') # Remove anything surrounded by paranthesis
      ep = /(\d+)/.match(raw_name)
      name = raw_name.gsub(/(\d+)/, '')
      episode = ep.nil? ? 1 : ep[1].to_i
      return name.strip!, episode
    end

    def scrobble anime, ep
      tries = 5
      begin
        info = MyAnimeList.search_anime(anime)
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
