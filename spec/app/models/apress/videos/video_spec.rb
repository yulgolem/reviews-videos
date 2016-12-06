# coding: utf-8
require 'spec_helper'
RSpec.describe ::Apress::Videos::Video, type: :model do
  let(:video) { create :'apress/videos/video' }
  
  context 'when has a provider' do
    let(:provider) { create :'apress/videos/provider' }

    it { is_expected.to belong_to(:provider) }
    it { is_expected.to validate_presence_of(:provider_id) }
    it { expect(video.provider).to eq(provider) }
  end

  context 'when wrong url' do
    let(:video) { build :'apress/videos/video', url: 'www.lenta.ru' }

    it { expect { video.save! }.to raise_error(ActiveRecord::RecordInvalid) }
  end

  context 'when has an URL' do
    it { is_expected.to validate_presence_of(:url) }
  end

  context 'when cuts the long url' do
    let!(:video2) do
      create(
        :'apress/videos/video',
        url: "#{video.url}?utm_source=telegram?utm_campaign=some_campaign",
        position: 2
      )
    end

    it { expect(video.url).to eq(video2.url) }
  end

  describe '#enqueue_receiving_oembed' do
    before do
      allow(Apress::Videos::ReceiveOembedJob).to receive(:enqueue)

      video.send(:enqueue_receiving_oembed)
    end

    it { expect(Apress::Videos::ReceiveOembedJob).to have_received(:enqueue) }
  end
end
