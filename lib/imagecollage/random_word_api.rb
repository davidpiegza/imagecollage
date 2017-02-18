require 'httparty'

module ImageCollage
  class RandomWordApi
    include HTTParty

    base_uri 'http://www.setgetgo.com/randomword/get.php'

    def self.fetch
      get('/').parsed_response
    end
  end
end
