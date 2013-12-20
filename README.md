rmpv
====

Ruby wrapper around [mpv](http://mpv.io/) with [trakt](http://trakt.tv) and [myanimelist](http://myanimelist.net) scrobble support.

[![Gem Version](https://badge.fury.io/rb/rmpv.png)](http://badge.fury.io/rb/rmpv)

## Installation

Add this line to your application's Gemfile:

    gem 'rmpv'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rmpv

## Usage

     Usage: rmpv [options]

     -+, --vol=VOL                    increase volume by VOL
     -l, --top-left                   play in top-left corner of the screen
     -b, --bottom-right               play in bottom-right corner of the screen
     -x, --speed SPEED                increase speed by SPEED
     -s, --size STR                   set size of the player
     -y, --youtube                    youtube mode
     -a, --audio                      audio mode
     -t, --trakt                      scrobble to trakt
     

TODO: Write usage instructions here

## Todo

- Add myanimelist scrobble support
- Use trakt scrobble rather than trakt seen for scrobbling. (This requires that we add scrobble support to [traktr](https://github.com/joelanford/traktr)).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
