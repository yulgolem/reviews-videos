# coding: utf-8
require 'spec_helper'

RSpec.describe Apress::Videos::FormTagHelper, type: :helper do
  describe '#video_field_tag' do
    subject { helper.video_field_tag('video', id: 'video_1', videos_limit: 5, subject_id: 1, subject_type: 'Dummy') }

    it 'renders div and javascript' do
      is_expected.to have_tag(
        :div,
        with: {
          class: %w(js-video-container)
        }
      )
      is_expected.to have_tag(:script)
    end
  end
end
