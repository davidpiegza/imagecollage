module ImageCollage
  class ImageUrlRequester
    def initialize(keywords, flickr_api, options = {})
      @keywords = keywords || []
      @flickr_api = flickr_api
      @options = options || {}

      @image_url_count = Integer(options[:image_url_count]) || 10
      @keywords_pool = fill_keywords_pool(@keywords)
    end

    def image_urls
      image_urls = []

      while image_urls.length < @image_url_count
        keyword = @keywords_pool.shift || random_keyword

        print "Fetching image (#{image_urls.length + 1}/#{@image_url_count}) for #{keyword}..."

        response = @flickr_api.photos_search(keyword: keyword)
        image_url = @flickr_api.parse_image_url(response.parsed_response)

        if image_url
          image_urls << image_url
          puts 'OK'
        else
          puts 'FAILED'
        end
      end

      image_urls
    end

    private

    def random_keyword
      RandomWordApi.fetch
    end

    def fill_keywords_pool(keywords)
      keywords_pool = Array.new(keywords)

      while keywords_pool.length < @image_url_count
        keywords_pool << random_keyword
      end

      keywords_pool
    end
  end
end
