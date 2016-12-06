module Apress
  module Videos
    class ReceiveOembedJob
      include Resque::Integration
      extend Resque::Plugins::ExponentialBackoff

      # Настройки экспоненциальной паузы между повторением джоба при сбоях, в секундах.
      @backoff_strategy = [10, 60, 600, 3_600, 10_800, 21_600]

      @queue = :videos

      unique { |video_id| video_id }

      # Public: при запуске джоб вызывает сервис для получения oembed от провайдера.
      #
      # video_id - Integer, идентификатор видео
      def self.execute(video_id)
        Apress::Videos::ReceiveOembedDataService.call(video_id)
      end
    end
  end
end
