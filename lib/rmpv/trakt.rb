#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# File: trakt.rb
#
# Copyright rejuvyesh <mail@rejuvyesh.com>, 2013

require 'traktr'
require 'yaml'
require 'rmpv/version'

module Rmpv
  class Trakt

    ##
    # Initialize the trakt client
    TRAKTAPIKEY = '5d7b4164188a3974e0ff4f0c571058dcd3a06f47'

    def initialize
      traktconfig = YAML.load File.open("#{Dir.home}/.rmpvrc")
      @trakt = Traktr::Client.new(TRAKTAPIKEY, \
                                  traktconfig["trakt"]["username"], \
                                  traktconfig["trakt"]["password"], true)
    end

    ##
    # Set as watching

    def watching(show, progress, type='show')
      tries = 5
      begin
        if type == 'show'
          info = @trakt.search.shows(show.name)
          res = @trakt.show.watching(info[0], show.series, show.episode, \
                                     progress, Rmpv::VERSION, Rmpv::BUILD)
        elsif type == 'movie'
          info = @trakt.search.movies(show.name)
          res = @trakt.movie.watching(info[0], progress, \
                                      Rmpv::VERSION, Rmpv::BUILD)
        end
        puts "Watching to trakt (Y) - #{show.name}"
      rescue Exception => e
        tries -= 1
        if tries > 0
          retry
        else
          puts "Couldn't connect to trakt servers: #{e}, #{res}"
        end
      end
      info[0].runtime # return duration
    end

    ##
    # Scrobble the show

    def scrobble(show, progress, type='show')
      tries = 5
      begin
        if type == 'show'
          info = @trakt.search.shows(show.name)
          res  = @trakt.show.scrobble(info[0], show.series, show.episode,\
                                      progress, Rmpv::VERSION, Rmpv::BUILD)
        elsif type == 'movie'
          info = @trakt.search.movies(show.name)
          res = @trakt.movie.scrobble(info[0], progress, \
                                      Rmpv::VERSION, Rmpv::BUILD)
        end
        puts "Scrobbled to trakt (Y) - #{show.name}"
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
