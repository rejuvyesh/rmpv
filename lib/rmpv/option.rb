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
    # cmd  : variable to which options are being added
    # options : value of the options
    #
    # returns the new cmd and options
    
    def self.parse args, cmd, options
      begin
        OptionParser.new do |opts|
          opts.banner = "Usage: rmpv [options]"

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
            options[:speed]    = 1.5
            cmd << "--cache-default=2048"
          end
          opts.on("-a", "--audio",        "audio mode") do |a|
            cmd << "--audio-display=no --gapless-audio"
          end
          opts.on("-t", "--trakt",        "scrobble to trakt") do |t| 
            options[:trakt]    = true;
          end
        end.parse!

      rescue OptionParser::InvalidOption => e
        cmd << e.to_s.sub(/^invalid option:\s+/, "")
      end

      return cmd, options
    end

    ##
    # Adds options to the command to be passed to mpv
    
    def self.command cmd, options
      # size
      if options[:size]
        cmd << "--autofit='#{options[:size]}'"
      end

      if options[:position] == :top_left
        cmd << "--geometry='0:17'"
      elsif options[:position] == :bottom_right
        cmd << "--geometry='100%:97%'"
      end

      # audio filter
      # Remove chirping at higher speed
      cmd << "--af=scaletempo"  
      if options[:volume].nonzero?
        cmd << "--af=volume=#{options[:volume]}"
      end

      # speed increase
      if options[:speed] != 1.0
        cmd << "--speed=#{options[:speed]}"
      end

      return cmd
    end
  end
end
