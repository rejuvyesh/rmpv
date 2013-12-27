#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# File: myanimelist.rb
#
# Copyright rejuvyesh <mail@rejuvyesh.com>, 2013

require 'yaml'
require 'myanimelist'
require 'httparty'

module Rmpv
  class MALRequester
    include HTTParty
    base_uri 'myanimelist.net'
    # headers 'User-Agent' => "api-team-f894427cc1c571f79da49605ef8b112f"
  end

  class Myanimelist
    ##
    # Initialize the Myanimelist client
    def initialize
      myanimeconfig = YAML.load File.open("#{Dir.home}/.rmpvrc")
      MyAnimeList.configure do |config|
        config.username = myanimeconfig["myanimelist"]["username"]
        config.password = myanimeconfig["myanimelist"]["password"]
      end
    end

    ##
    # Parse the file names
    #
    # @param [String] file name
    # @return [String, Fixnum] name of the show and episode number
    def parse(file)
      raw_name = file
      raw_name = raw_name[0, raw_name.rindex(/\./)] # remove extension
      raw_name = raw_name.gsub(/(\.|_|\-)/, '')  # Chars used in filenames as a substitute for spaces
      raw_name = raw_name.gsub(/\(.*?\)/, '') # Remove anything surrounded by paranthesis
      raw_name = raw_name.gsub(/\[.*?\]/, '') # Remove anything surrounded by paranthesis
      ep = /(\d+)/.match(raw_name)[1]
      name = raw_name.gsub(/(\d+)/, '').strip!
      episode = ep.nil? ? 1 : ep.to_i
      return name, episode
    end

    def scrobble(anime, ep)
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
