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
      traktconfig = YAML.load File.open("#{Dir.home}/.traktrc")
      @trakt = Traktr::Client.new(traktconfig["api_key"], traktconfig["username"], traktconfig["password"], true)
    end

    ##
    # Scrobble the show
    
    def scrobble show
      tries = 5
      begin
        info = @trakt.search.shows(show.name)
        # @episodes = @trakt.show.season(info[0].title, show.series)
        # res = @trakt.show.episode.seen(info[0], @episodes[show.episode-1..show.episode-1])
        res = @trakt.show.checkin(info[0], show.series, show.episode, Rmpv::VERSION, "Dec 22 2013")
        puts "Checked-in to trakt (Y)"
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
