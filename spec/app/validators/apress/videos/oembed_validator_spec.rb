# coding: utf-8
require 'spec_helper'

describe Apress::Videos::OembedValidator do
  shared_context 'check field for absense' do |key|
    let(:video) do
      build :'apress/videos/video', oembed_data: JSON.parse('{"html": "Test_HTML",
                                                              "thumbnail_url": "test_thubmnail_url",
                                                              "provider_name": "YouTube"}').select { |k, v| k != key }
    end
    let(:key) { key }

    it do
      video.invalid?
      expect(video.errors[:oembed_data][0]).to include(key)
    end
  end

  context 'when validates correct data' do
    let(:video) { build :'apress/videos/video', :with_oembed_data }

    it { expect(video).to be_valid }
  end

  context 'when html is absend' do
    include_context 'check field for absense', 'html'
  end

  context 'when thumbnail_url is absend' do
    include_context 'check field for absense', 'thumbnail_url'
  end

  context 'when provider_name is absend' do
    include_context 'check field for absense', 'provider_name'
  end
end
