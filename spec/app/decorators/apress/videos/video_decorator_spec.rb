# coding: utf-8
require 'spec_helper'

describe Apress::Videos::VideoDecorator do
  let(:video) { create :'apress/videos/video', :with_oembed_data }

  context 'when parses with correct data' do
    let!(:decorated_video) { video.decorate }

    it do
      expect(decorated_video.thumbnail).to eq 'test_thubmnail_url'
      expect(decorated_video.iframe).to eq 'Test_HTML'
      expect(decorated_video.provider_name).to eq 'YouTube'
    end
  end
end
