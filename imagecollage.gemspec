# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imagecollage/version'

Gem::Specification.new do |spec|
  spec.name          = 'imagecollage'
  spec.version       = ImageCollage::VERSION
  spec.authors       = ['David Piegza']
  spec.homepage      = 'https://github.com/davidpiegza/imagecollage'
  spec.summary       = 'ImageCollage creates a collage based on images from Flickr.'
  spec.license       = 'MIT'

  spec.post_install_message = <<-MESSAGE
    ImageCollage has been installed successfully!

    Make sure to set a Flickr api key via env variable (export FLICKR_API_KEY=api_key) or
    provide it when running this gem.

    Example:
      imagecollage berlin naples barcelona
  MESSAGE

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'bin'
  spec.executables   = ['imagecollage']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httparty', '~> 0.14'
  spec.add_runtime_dependency 'rmagick', '~> 2.16'
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 2.3'
  spec.add_development_dependency 'rubocop', '~> 0.46'
end
