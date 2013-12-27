#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# File: option.rb
#
# Copyright rejuvyesh <mail@rejuvyesh.com>, 2013

require "optparse"

##
# This class represents the options that can be passed to `rmpv`

module Rmpv
  class Option
    ##
    # Parses the commandline options
    # args : the arguments to be passed
    #
    # returns the new cmd and options

    def self.parse(args)
      cmd = ['mpv']
      options = { volume: 0, speed: 1.0, }
      begin
        OptionParser.new do |opts|
          opts.banner = 'Usage: rmpv [options]'

          opts.on("-+", "--vol=VOL", Integer, "increase volume by VOL") do |v|
            options[:volume]   = v
          end
          opts.on("-l", "--top-left",     "play in top-left corner of the screen") do |tl|
            options[:position] = :top_left
          end
          opts.on("-b", "--bottom-right", "play in bottom-right corner of the screen") do |br|
            options[:position] = :bottom_right
          end
          opts.on("-x", "--speed SPEED",  Float, "increase speed by SPEED") do |x|
            options[:speed]    = x
          end
          opts.on("-s", "--size STR",     "set size of the player") do |sa|
            options[:size]     = sa
          end
          opts.on("-y", "--youtube",      "youtube mode") do |y|
            options[:mode] = 'youtube'
            options[:speed]    = 1.5
          end
          opts.on("-a", "--audio",        "audio mode") do |a|
            options[:mode] = 'audio'
          end
          opts.on("-c", "--scrobble STR",     "scrobble 'movie' or 'show' to trakt or 'anime' to myanimelist") do |sa|
            options[:method]  = sa.downcase
          end
        end.parse!
      rescue OptionParser::InvalidOption => e
        cmd << e.to_s.sub(/^invalid option:\s+/, '')
      end
      return cmd, options
    end

    ##
    # Adds options to the command to be passed to mpv

    def self.command(cmd, options)
      ## Saner defaults
      # save position on exit
      cmd << '--save-position-on-quit'
      # audio filter
      # Remove chirping at higher speed
      cmd << "--af=scaletempo"

      # size
      cmd << "--autofit='#{options[:size]}'" if options[:size]

      # position
      if options[:position] == :top_left
        cmd << "--geometry='0:17'"
      elsif options[:position] == :bottom_right
        cmd << "--geometry='100%:97%'"
      end

      # audio
      cmd << "--af=volume=#{options[:volume]}" if options[:volume].nonzero?

      cmd << "--audio-display=no --gapless-audio" if options[:mode] == 'audio'

      # speed increase
      cmd << "--speed=#{options[:speed]}" if options[:speed] != 1.0

      # youtube mode

      cmd << "--cache-default=2048" if options[:mode] == 'youtube'

      cmd
    end
  end
end
