require 'spec_helper'

describe ImageCollage::ImageUrlRequester do
  let(:flickr_api_mock) { double('FlickrApi') }

  describe 'image_urls' do
    before do
      allow(ImageCollage::RandomWordApi).to receive(:fetch).and_return 'random'

      allow(flickr_api_mock).to receive(:photos_search).with(anything) do |value|
        double('ParsedResponse', parsed_response: value[:keyword])
      end

      allow(flickr_api_mock).to receive(:parse_image_url).with(anything) do |value|
        value
      end
    end

    context 'given image_url_count of 3' do
      subject(:image_url_requester) do
        described_class.new(
          keywords,
          flickr_api_mock,
          image_url_count: '3'
        )
      end

      context 'given 3 keywords' do
        let(:keywords) { %w(cat dog berlin) }

        it 'returns 3 image urls' do
          expect(image_url_requester.image_urls)
            .to eq keywords
        end
      end

      context 'given 1 keyword' do
        let(:keywords) { ['berlin'] }

        it 'returns 3 image urls' do
          expect(image_url_requester.image_urls)
            .to eq %w(berlin random random)
        end
      end

      context 'without keywords' do
        let(:keywords) { nil }

        it 'returns 3 random image urls' do
          expect(image_url_requester.image_urls)
            .to eq ['random'] * 3
        end
      end
    end
  end
end
