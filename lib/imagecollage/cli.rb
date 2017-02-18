module ImageCollage
  class Cli
    IMAGE_COLLAGE_DEFAULT_PATH = './collage.jpg'.freeze

    def run(args = ARGV)
      flickr_api_key = fetch_flickr_api_key
      image_collage_path = fetch_image_collage_path

      options = {
        flickr_api_key: flickr_api_key,
        image_collage_path: image_collage_path
      }

      runner = Runner.new(args, options)

      return runner.run
    rescue ImageCollage::Error => e
      $stderr.puts
      $stderr.puts "Error: #{e.message}"
      return 2
    rescue StandardError => e
      $stderr.puts e.message
      $stderr.puts e.backtrace
      return 2
    end

    private

    def fetch_flickr_api_key
      if (api_key = ENV['FLICKR_API_KEY']).nil?
        $stdout.puts 'Please provide a Flickr API key and set it as a'
        $stdout.puts 'shell environment variable (FLICKR_API_KEY) or paste it here.'

        api_key = ask 'Flickr API KEY:'

        raise ImageCollage::Error, 'Invalid Flickr API key' if api_key.empty?
      end

      api_key
    end

    def fetch_image_collage_path
      $stdout.puts 'Please provide a path for the generated collage image (default: current path).'
      path = ask "Image collage path (#{IMAGE_COLLAGE_DEFAULT_PATH}):"
      path = IMAGE_COLLAGE_DEFAULT_PATH if path.empty?

      raise ImageCollage::Error, 'Invalid path' unless File.directory?(File.dirname(path))

      path
    end

    def ask(message)
      $stdout.puts
      $stdout.print "#{message} "
      result = $stdin.gets.chomp
      $stdout.puts

      result
    end
  end
end
