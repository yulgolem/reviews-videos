# coding: utf-8
module Apress
  module Videos
    module FormTagHelper
      # Public: формирует конфиг для видео
      #
      # videos_limit - Integer, макс. кол-во загружаемых видео за раз
      #
      # Returns String
      def video_field_tag(name, options = {})
        field_options = {
          class: options.fetch(:class, 'js-video-container'),
          id: options.fetch(:id, ''),
          data: options.fetch(:data, '')
        }

        js_options = {
          videos_limit: options.fetch(:videos_limit, 1),
          regexp: options.fetch(:regexp, 1),
          subject_type: options.fetch(:subject_type),
          subject_id: options.fetch(:subject_id, '')
        }

        capture do
          concat tag(:div, field_options)
          concat "\n"
          concat render(partial: 'apress/videos/require/config', locals: {options: js_options})
        end
      end
    end
  end
end
