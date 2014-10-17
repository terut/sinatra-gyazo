require "sinatra/gyazo/version"
require "sinatra"
require 'fileutils'
require 'pathname'
require 'digest/md5'
require 'sdbm'

module Sinatra
  module Gyazo
    module Helpers
      def host(request)
        host = "#{request.scheme}://#{request.host}"
        host << ":#{request.port}" unless request.port == 80
        host
      end

      def image_path(image_dir, data)
        hash = Digest::MD5.hexdigest(data + Time.now.to_s).to_s
        year = Date.today.year

        Pathname.new("#{image_dir}/#{year}/#{section(hash)}/#{hash}.png")
      end

      private
      def section(hash)
        hash[0..1]
      end
    end

    class << self
      def registered(app)
        app.helpers Gyazo::Helpers

        app.set :dbm_path, 'db/id'
        app.set :image_dir, 'images'

        app.post '/gyazo' do
          data = request[:imagedata][:tempfile].read

          image_path = image_path(settings.image_dir, data)
          while File.exists?("#{settings.public_folder}/#{image_path}")
            image_path = image_path(settings.image_dir, data)
          end

          directory = "#{settings.public_folder}/#{image_path.dirname}"
          FileUtils.mkdir_p(directory, mode: 0755)

          # TODO have to store?
          id = request[:id]
          dbm = SDBM.open(settings.dbm_path, 0644)
          dbm[image_path.to_s] = id

          File.open("#{settings.public_folder}/#{image_path}", 'w'){|f| f.write(data)}
          "#{host(request)}/#{image_path}"
        end
      end
    end
  end
end
