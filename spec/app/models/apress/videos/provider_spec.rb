# coding: utf-8
require 'spec_helper'

RSpec.describe ::Apress::Videos::Provider, type: :model do
  let(:provider) { create :'apress/videos/provider' }
  let(:url) { 'https://www.youtube.com/watch?v=NTmk0Pqk6hs' }

  describe '.find_by_video_url' do
    context 'when found' do
      it { expect(described_class.find_by_video_url(url)).to eq(provider) }
    end

    context 'when not found' do
      let(:url) { 'http://www.lenta.ru' }
      it { expect(described_class.find_by_video_url(url)).to be_nil }
    end
  end
end
