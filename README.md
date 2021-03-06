# ImageCollage

ImageCollage creates a collage based on images from Flickr.

## Installation

#### ImageMagick

This gem requires [ImageMagick](http://www.imagemagick.org) in order to run. Check the
[download section](http://www.imagemagick.org/script/download.php) at ImageMagick to get
instructions on how to install it.

Install it via homebrew (OSX):

    $ brew install imagemagick@6

#### ImageCollage

Install it via gem:

    $ gem install imagecollage

If you get an error while installing `rmagick` you could try installing it with:

    $ PKG_CONFIG_PATH=/usr/local/opt/imagemagick@6/lib/pkgconfig gem install rmagick

## Usage

Run

    $ imagecollage berlin tower cat dog flower cherry

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davidpiegza/imagecollage.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
