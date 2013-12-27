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

First create a `.rmpvrc` file (which BTW is just a yaml file) in your home directory and add the following content:

```yaml
trakt:
  username: TRAKT_USERNAME
  password: SHA1_HASH_OF_YOUR_PASSWORD
myanimelist:
  username: MYANIMELIST_USERNAME
  password: MYANIMELIST_PASSWORD
```

You can use the following command to generate the SHA1 hash of your password:

```sh
echo -n trakt_password | sha1sum | awk '{print toupper($1)}'
```

     Usage: rmpv [options]

     -+, --vol=VOL                    increase volume by VOL
     -l, --top-left                   play in top-left corner of the screen
     -b, --bottom-right               play in bottom-right corner of the screen
     -x, --speed SPEED                increase speed by SPEED
     -s, --size STR                   set size of the player
     -y, --youtube                    youtube mode
     -a, --audio                      audio mode
     -c, --scrobble STR               scrobble 'movie' or 'show' to trakt or 'anime' to myanimelist
     

## Todo

- Add myanimelist scrobble support

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
