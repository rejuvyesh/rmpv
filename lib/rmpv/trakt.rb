#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# File: trakt.rb
#
# Copyright rejuvyesh <mail@rejuvyesh.com>, 2013

require "traktr"
require "yaml"

module Rmpv
  class Trakt
    def self.traktscrobble show
      traktconfig = YAML.load File.open("#Dir.home/.traktrc")
      @trakt = Trakt::Client.new(traktconfig["api_key"], traktconfig["username"], traktconfig["password"], true)
      tries = 5
      begin
        info = @trakt.search.shows(show.name)
        @episodes = @trakt.show.season(info[0].title, show.series)
        res = @trakt.show.episode.seen(info[0], @episodes[show.episode-1..show.episode-1])
      rescue Exception => e
        tries -= 1
        if tries > 0
          retry
        else
          puts "Couldn't connect to trakt servers"
        end
      end
    end
  end
end
