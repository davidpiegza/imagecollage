require 'spec_helper'

describe ImageCollage::CollageGenerator do
  let(:image_urls) { %w(cat dog berlin) }
  let(:path) { './' }

  let(:temp_file_mock) { double('Tempfile', write: true, rewind: true, close: true, unlink: true, path: '') }

  let(:image_mock) { double('Image') }
  let(:image_list_mock) { double('ImageList') }

  subject(:collage_generator) { described_class.new(image_urls) }

  describe 'generate_image_collage' do
    before do
      allow(Tempfile).to receive(:new).and_return temp_file_mock
      allow(collage_generator).to receive(:open)

      expect(ImageCollage::CollageGenerator::ImageList).to receive(:new).and_return image_list_mock

      expect(image_list_mock).to receive(:each).and_yield image_mock

      expect(image_mock).to receive(:resize_to_fill!).with(320, 240)
      expect(image_list_mock).to receive(:montage).and_return image_list_mock

      expect(image_list_mock).to receive(:write).with(path)
    end

    it 'creates an image collage' do
      collage_generator.generate_image_collage(path)
    end

    it 'closes all temp files' do
      expect(temp_file_mock).to receive(:close).exactly(image_urls.length).times
      collage_generator.generate_image_collage(path)
    end
  end
end
