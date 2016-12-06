# coding: utf-8
module Apress
  module Videos
    class Provider < ActiveYaml::Base
      # Public: Класс и его атрибуты формируются на основании providers.yml, лежащего в /config гема
      set_root_path Apress::Videos::Engine.root.join('config')
      set_filename 'providers'

      # Public: Возвращает провайдера, которому соответствует url. Если такого не найдено,
      # то возвращает nil.
      #
      # args - url видео.
      #
      # Examples
      #
      #  provider = Apress::Videos::Provider.find_by_video_url('https://www.youtube.com/watch?v=dQw4w9WgXcQ')
      #
      # Returns объект Apress::Videos::Provider
      def self.find_by_video_url(url)
        Provider.all.detect { |provider| url =~ /#{provider.regex}/ }
      end

      ActiveSupport.run_load_hooks(:'apress/videos/provider', self)
    end
  end
end
