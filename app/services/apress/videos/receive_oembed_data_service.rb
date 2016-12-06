require 'net/http'
require 'uri'

module Apress
  module Videos
    class ReceiveOembedDataService
      # Public: Возвращает объект видео. Заполняется на инициализации сервиса по идентификатору.
      attr_reader :video

      def initialize(video_id)
        @video = Apress::Videos::Video.find(video_id)
      end

      def self.call(video_id)
        new(video_id).call
      end

      # Public: Получает oembed от провайдера и сохраняет его в видео-объект.
      def call
        path = video.provider.endpoint % {url: video.url}
        video.oembed_data = oembed(path)
        video.save!
      end

      private

      # Internal: Получает путь к oembed, возвращает oembed для сохранения
      def oembed(path)
        uri = URI.parse(path)
        JSON.parse(establish_connection(uri.host, uri.port).get(uri.request_uri).body)
      rescue
        nil
      end

      # Internal: Обеспечивает HTTP-соединение для получения oembed
      def establish_connection(host, port)
        Net::HTTP.new(host, port).tap do |instance|
          instance.read_timeout = 10
          instance.use_ssl = port == URI::HTTPS::DEFAULT_PORT
        end
      end
    end
  end
end
