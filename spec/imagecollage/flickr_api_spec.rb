require 'spec_helper'

describe ImageCollage::FlickrApi do
  subject(:flickr_api) { described_class.new('12345') }

  describe 'photos_search' do
    context 'without options' do
      it 'returns an image url' do
        VCR.use_cassette('photos_search') do
          response = flickr_api.photos_search
          expect(flickr_api.parse_image_url(response.parsed_response))
            .to include 'https://farm9.staticflickr.com'
        end
      end
    end

    context 'with keyword option' do
      it 'returns an image url' do
        VCR.use_cassette('photos_search_keyword') do
          response = flickr_api.photos_search(keyword: 'forest')
          expect(flickr_api.parse_image_url(response.parsed_response))
            .to include 'https://farm9.staticflickr.com'
        end
      end

      it 'contains the keyword in the title' do
        VCR.use_cassette('photos_search_keyword') do
          response = flickr_api.photos_search(keyword: 'forest')
          title = ImageCollage::ResponseParser.new(response.parsed_response).fetch('title')
          expect(title).to include 'forest'
        end
      end
    end
  end

  describe 'parse_image_url' do
    context 'with invalid response' do
      it 'returns nil' do
        expect(flickr_api.parse_image_url({'rsp' => 'invalid'})).to be_nil
      end
    end

    context 'given nil' do
      it 'returns nil' do
        expect(flickr_api.parse_image_url(nil)).to be_nil
      end
    end
  end

  context 'without api key' do
    it 'raises an error' do
      expect{ described_class.new(nil) }.to raise_error ImageCollage::Error
    end
  end
end
