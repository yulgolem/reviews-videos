# coding: utf-8
module Apress
  module Videos
    class VideoDecorator < Draper::Decorator
      delegate_all

      def iframe
        oembed_data['html']
      end

      def thumbnail
        oembed_data['thumbnail_url']
      end

      def provider_name
        oembed_data['provider_name']
      end
    end
  end
end
