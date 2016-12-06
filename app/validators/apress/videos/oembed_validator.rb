module Apress
  module Videos
    class OembedValidator < ActiveModel::EachValidator
      FIELDS = %w(html thumbnail_url provider_name).freeze

      def validate_each(record, attribute, value)
        absend_fields = FIELDS.select { |f| value[f].blank? }

        if absend_fields.present?
          message = options.fetch(:message, I18n.t('validators.oembed.message', fields: absend_fields.join(', ')))
          record.errors.add(attribute, message)
        end
      end
    end
  end
end
