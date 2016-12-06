# coding: utf-8
require 'spec_helper'
RSpec.describe ::Apress::Videos::ReceiveOembedDataService do
  let(:video) { create :video, id: 1 }
  let(:url) { 'https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=NVkvQHk4euM' }
  let(:video_with_data) { build_stubbed :video, :with_oembed_data }
  let(:body) { video_with_data.oembed_data.to_s }

  before do
    WebMock.stub_request(:get, url).
      with(headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Ruby'}).
      to_return(status: 200, body: body, headers: {})
  end

  describe '#call' do
    context 'when service receives oembed_data from provider' do
      before { allow(described_class).to receive(:call) }

      it { expect(described_class.new(video.id).call).to eq true }
    end
  end
end
