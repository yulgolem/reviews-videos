# coding: utf-8
require 'uri'

module Apress
  module Videos
    class Video < ActiveRecord::Base
      extend ActiveHash::Associations::ActiveRecordExtensions

      PROCESSING = 'processing'.freeze

      belongs_to_active_hash :provider, class_name: 'Apress::Videos::Provider'
      belongs_to :subject, polymorphic: true, inverse_of: :videos

      # До валидации, если произошло изменение url, перепривязать провайдера.
      before_validation :link_provider, if: :url_changed?

      serialize :oembed_data, JSON

      validates :provider_id, :url, :position, presence: true
      validates :oembed_data, length: {maximum: 4000}
      validates :oembed_data, oembed: true, if: proc { |r| r.oembed_data.present? }

      # Если произошло изменение url, то после сохранения - получить от провайдера oembed
      after_save -> { @need_to_receive_oembed = true }, if: :url_changed?
      after_commit :enqueue_receiving_oembed, if: -> { @need_to_receive_oembed }

      def status
        PROCESSING if ReceiveOembedJob.enqueued?(id)
      end

      private

      # Internal: Перепривязывает провайдера, поднимает ошибку, если url не соответствует
      # по регексу ни одному провайдеру.
      #
      # Строка self.url = url.match(/#{provider.regex}/).to_s - это обрезка URL по регексу
      def link_provider
        self.provider = Provider.find_by_video_url(url)
        self.url = url.match(/#{provider.regex}/).to_s if provider
      end

      # Internal: Запускает джоб по получению oembed от провайдера
      def enqueue_receiving_oembed
        ReceiveOembedJob.enqueue(id)
      ensure
        @need_to_receive_oembed = false
      end

      ActiveSupport.run_load_hooks(:'apress/videos/video', self)
    end
  end
end
