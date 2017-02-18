module ImageCollage
  class Runner

    attr_reader :keywords, :options

    COLLAGE_IMAGE_COUNT = 10

    def initialize(keywords, options)
      @keywords = keywords
      @options = options || {}
    end

    def run
      flickr_api = ImageCollage::FlickrApi.new(@options.fetch(:flickr_api_key))
      image_url_requester = ImageUrlRequester.new(@keywords, flickr_api, image_url_count: COLLAGE_IMAGE_COUNT)

      collage_generator = CollageGenerator.new(image_url_requester.image_urls)
      collage_generator.generate_image_collage(@options.fetch(:image_collage_path))

      return 0
    end
  end
end
