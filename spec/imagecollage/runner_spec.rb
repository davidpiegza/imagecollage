require 'spec_helper'

describe ImageCollage::Runner do
  subject(:runner) { described_class.new(keywords, options) }

  let(:keywords) { %w(cat dog) }
  let(:options) { {flickr_api_key: '12345', image_collage_path: './collage.jpg', image_url_count: 3} }
  let(:flickr_api_mock) { double('FlickrApi') }
  let(:image_url_requester_mock) { double('ImageUrlRequester', image_urls: keywords) }
  let(:collage_generator_mock) { double('CollageGenerator') }

  describe 'run' do
    before do
      expect(ImageCollage::FlickrApi).to receive(:new).with('12345').and_return flickr_api_mock
      expect(ImageCollage::ImageUrlRequester).to receive(:new).with(keywords, flickr_api_mock, image_url_count: 10).and_return image_url_requester_mock
      expect(ImageCollage::CollageGenerator).to receive(:new).with(keywords).and_return collage_generator_mock
      expect(collage_generator_mock).to receive(:generate_image_collage).with(options.fetch(:image_collage_path))
    end

    it 'returns with an exit code' do
      expect(runner.run).to eq 0
    end
  end
end
