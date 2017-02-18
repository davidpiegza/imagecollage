require 'httparty'

module ImageCollage
  class FlickrApi
    include HTTParty

    base_uri 'https://api.flickr.com/services/rest'

    def initialize(api_key)
      @api_key = api_key || ''

      raise ImageCollage::Error, 'Invalid Flickr API key' if @api_key.empty?
    end

    def photos_search(options = {})
      self.class.get('', photos_search_options(options))
    end

    def parse_image_url(response)
      ResponseParser.new(response).fetch('url_z')
    end

    private

    def photos_search_options(options)
      {
        query: {
          method: 'flickr.photos.search',
          api_key: @api_key,
          text: options[:keyword] || 'berlin',
          extras: 'url_z',
          per_page: 1,
          sort: 'interestingness-desc'
        }
      }
    end
  end

  class ResponseParser
    PHOTO_PATH = ['rsp', 'photos', 'photo'].freeze

    def initialize(response)
      @response = response # TODO Wrap in a Hash if needed
    end

    def fetch(key)
      photo_data[key]
    end

    def photo_data
      @_photo_data ||= PHOTO_PATH.reduce(@response) do |subdata, el|
        break unless subdata
        subdata[el]
      end

      @_photo_data || {}
    end
  end
end
