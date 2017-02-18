require 'spec_helper'

describe ImageCollage::Cli do
  subject(:cli) { described_class.new }

  describe 'run' do
    let(:args) { %w(cat dog berlin) }
    let(:runner_mock) { double('Runner') }
    let(:return_code) { 0 }
    let(:flickr_api_key) { '12345' }
    let(:image_collage_path) { './collage.jpg' }

    before do
      ENV['FLICKR_API_KEY'] = nil

      allow(runner_mock).to receive(:run).and_return return_code
      allow(cli).to receive(:ask).with('Flickr API KEY:').and_return flickr_api_key
      allow(cli).to receive(:ask).with('Image collage path (./collage.jpg):').and_return image_collage_path
    end

    context 'given api key in ENV' do
      before do
        ENV['FLICKR_API_KEY'] = 'abcde'
      end

      it 'fetches the flickr api key from ENV' do
        expect(ImageCollage::Runner)
          .to receive(:new)
          .with(args, flickr_api_key: 'abcde', image_collage_path: './collage.jpg')
          .and_return(runner_mock)
        cli.run(args)
      end
    end

    context 'without api key in ENV' do
      it 'asks for the flickr api key' do
        expect(ImageCollage::Runner)
          .to receive(:new)
          .with(args, flickr_api_key: '12345', image_collage_path: './collage.jpg')
          .and_return(runner_mock)
        cli.run(args)
      end

      context 'provided empty api key' do
        let(:flickr_api_key) { '' }

        it 'returns with error code 2' do
          expect(cli.run(args)).to eq 2
        end
      end
    end

    it 'uses the default image collage path' do
      expect(ImageCollage::Runner)
        .to receive(:new)
        .with(args, flickr_api_key: '12345', image_collage_path: './collage.jpg')
        .and_return(runner_mock)
      cli.run(args)
    end

    context 'provided image collage path' do
      let(:image_collage_path) { './spec' }

      it 'uses the provided path' do
        expect(ImageCollage::Runner)
          .to receive(:new)
          .with(args, flickr_api_key: '12345', image_collage_path: './spec')
          .and_return(runner_mock)
        cli.run(args)
      end

      context 'given invalid collage path' do
        let(:image_collage_path) { './invalid/path' }

        it 'returns with error code 2' do
          expect(cli.run(args)).to eq 2
        end
      end
    end

    context 'given runner\'s return code' do
      let(:return_code) { 1 }

      it 'returns with code 1' do
        allow(ImageCollage::Runner)
          .to receive(:new)
          .and_return(runner_mock)

        expect(cli.run(args)).to eq 1
      end
    end
  end
end
