require 'RMagick'
require 'open-uri'

module ImageCollage
  class CollageGenerator
    include Magick

    def initialize(image_urls)
      @image_urls = image_urls
    end

    def generate_image_collage(path)
      tmp_files = []
      @image_urls.each do |image_url|
        tmp_file = Tempfile.new(['image_collage', '.jpg'])

        open(image_url) do |image_file|
          tmp_file.write(image_file.read)
        end

        tmp_file.rewind
        tmp_files << tmp_file
      end

      image_list = ImageList.new(*tmp_files.map(&:path))

      resize!(image_list)
      image_list = montage(image_list)

      image_list.write(path)
    ensure
      tmp_files.each do |tmp_file|
        tmp_file.close
        tmp_file.unlink
      end
    end

    private

    def resize!(image_list)
      image_list.each do |image|
        image.resize_to_fill!(320, 240)
      end
    end

    def montage(image_list)
      image_list.montage do
        self.geometry = '320x240+0+0>'
        rows = (image_list.size + 4) / 5
        self.tile = Geometry.new(5,rows)
      end
    end
  end
end
