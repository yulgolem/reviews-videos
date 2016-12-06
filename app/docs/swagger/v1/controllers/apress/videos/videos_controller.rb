# coding: utf-8
module Swagger
  module V1
    module Controllers
      module Apress
        module Videos
          class VideosController < ::Apress::Api::Swagger::Schema
            swagger_path '/videos/{video_id}' do
              operation :get do
                key :produces, ['application/json']

                key :description,
                    'Получение информации о видео' \
                        '<h4>Доступ</h4>' \
                        'Любой пользователь'
                key :operationId, 'videos/show'
                key :tags, ['videos']

                parameter do
                  key :name, :video_id
                  key :in, :path
                  key :description, 'ID видео'
                  key :required, true
                  key :type, :integer
                end

                response 200 do
                  key :description, 'Success response'
                  schema type: 'object' do
                    property :video do
                      key :'$ref', :'Swagger::V1::Models::Apress::Videos::Video'
                    end
                  end
                end

                response 503 do
                  key :description, 'Updates are locked. Service is unavailable.'
                end
              end
            end
          end
        end
      end
    end
  end
end
