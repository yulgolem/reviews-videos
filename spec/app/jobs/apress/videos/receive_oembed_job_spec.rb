# coding: utf-8
require 'spec_helper'
RSpec.describe ::Apress::Videos::ReceiveOembedJob do
  let(:video) { create :video }

  describe '.execute' do
    after { described_class.execute(video.id) }

    it { expect(Apress::Videos::ReceiveOembedDataService).to receive(:call) }
  end
end
