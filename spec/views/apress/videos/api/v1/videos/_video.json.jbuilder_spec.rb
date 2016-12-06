require 'spec_helper'

describe 'apress/videos/api/v1/videos/_video', type: :view do
  let(:video) { create :video, :with_oembed_data }

  let(:schema) do
    {
      type: 'object',
      required: [%w(id url oembed_data position status)],
      properties: {
        id: {type: 'integer'},
        url: {type: 'string'},
        oembed_data: {type: 'hash'},
        position: {type: 'integer'},
        status: {type: 'string'}
      }
    }.with_indifferent_access
  end

  before do
    allow(video).to receive(:status).and_return(Apress::Videos::Video::PROCESSING)

    render template: 'apress/videos/api/v1/videos/_video',
           locals: {video: video},
           formats: :json, hander: :jbuilder
  end

  it { expect(rendered).to match_json_schema(schema) }
end
