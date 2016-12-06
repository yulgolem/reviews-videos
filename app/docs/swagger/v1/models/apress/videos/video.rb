# coding: utf-8
module Swagger
  module V1
    module Models
      module Apress
        module Videos
          class Video < ::Apress::Api::Swagger::Schema
            swagger_schema name.to_sym do
              key :required, [:id, :url, :oembed_data, :position, :status]

              property :id, type: :integer do
                key :example, '1'
              end

              property :url, type: :string do
                key :example, 'https://www.youtube.com/watch?v=SZymd6r4wGg'
              end

              property :oembed_data, type: :string do
                key :example, <<-JSON.squish
                  {"provider_name":"YouTube","type":"video","width":480,"version":"1.0","thumbnail_width":480,
                  "author_url":"https:\/\/www.youtube.com\/channel\/UCQSuIHSbDFH6Enz3AXeUHaA","thumbnail_height":360,
                  "height":270,"author_name":"Author","provider_url":"https:\/\/www.youtube.com\/",
                  "html":"\u003ciframe width=\"480\" height=\"270\" src=\"https:\/\/www.youtube.com\/embed\/
                  SZymd6r4wGg?feature=oembed\" frameborder=\"0\" allowfullscreen\u003e\u003c\/iframe\u003e",
                  "thumbnail_url":"https:\/\/i.ytimg.com\/vi\/SZymd6r4wGg\/hqdefault.jpg","title":"Title"}
                JSON
              end

              property :position, type: :integer do
                key :example, '1'
              end

              property :status, type: :string do
                key :example, 'processing'
              end
            end
          end
        end
      end
    end
  end
end
