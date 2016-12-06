# coding: utf-8
require 'spec_helper'

describe Apress::Videos::Api::V1::VideosController, type: :controller do
  let(:video) { create :video, :with_oembed_data }

  describe '#show' do
    context 'when id persisted' do
      it 'returns 200' do
        get :show, format: :json, id: video.id

        expect(response.status).to eq 200
      end
    end

    context 'when id does not exists' do
      it 'returns 404' do
        get :show, format: :json, id: -1

        expect(response.status).to eq 404
      end

      it 'returns 404' do
        get :show, format: :json, id: 'spam'

        expect(response.status).to eq 404
      end
    end
  end
end
