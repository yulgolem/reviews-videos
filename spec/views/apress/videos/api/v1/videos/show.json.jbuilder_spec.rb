require 'spec_helper'

describe 'apress/videos/api/v1/videos/show', type: :view do
  let(:video) { create :video, :with_oembed_data }

  let(:schema) do
    {
      type: 'object',
      required: ['video'],
      properties: {
        video: {
          required: [%w(id url oembed_data position status)],
          properties: {
            id: {type: 'integer'},
            url: {type: 'string'},
            oembed_data: {type: 'hash'},
            position: {type: 'integer'},
            status: {type: 'string'}
          }
        }
      }
    }.with_indifferent_access
  end

  before do
    allow(video).to receive(:status).and_return(Apress::Videos::Video::PROCESSING)

    assign(:video, video)

    render template: 'apress/videos/api/v1/videos/show',
           formats: :json, hander: :jbuilder
  end

  it { expect(rendered).to match_json_schema(schema) }
end
