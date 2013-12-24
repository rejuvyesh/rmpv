#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# File: trakt.rb
#
# Copyright rejuvyesh <mail@rejuvyesh.com>, 2013

require "traktr"
require "yaml"
require "rmpv/version"

module Rmpv
  class Trakt

    ##
    # Initialize the trakt client
    
    def initialize
      traktconfig = YAML.load File.open("#{Dir.home}/.rmpvrc")
      @trakt = Traktr::Client.new(traktconfig["trakt_api_key"], traktconfig["trakt_username"], traktconfig["trakt_password"], true)
    end

    ##
    # Set as watching

    def watching show, progress
      tries = 5
      begin
        info = @trakt.search.shows(show.name)
        res = @trakt.show.watching(info[0], show.series, show.episode, progress, Rmpv::VERSION, "Dec 22 2013")
        puts "Watching to trakt (Y)"
      rescue Exception => e
        tries -= 1
        if tries > 0
          retry
        else
          puts "Couldn't connect to trakt servers: #{e}, #{res}"
        end
      end
      info[0].duration
    end
    
    ##
    # Scrobble the show
    
    def scrobble show
      tries = 5
      begin
        info = @trakt.search.shows(show.name)
        res = @trakt.show.scrobble(info[0], show.series, show.episode, 85, Rmpv::VERSION, "Dec 22 2013")
        puts "Scrobbled to trakt (Y)"
      rescue Exception => e
        tries -= 1
        if tries > 0
          retry
        else
          puts "Couldn't connect to trakt servers: #{e}, #{res}"
        end
      end
    end
  end
end
