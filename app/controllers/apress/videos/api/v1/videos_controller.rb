# coding: utf-8
module Apress
  module Videos
    module Api
      module V1
        class VideosController < Apress::Api::ApiController::Base
          skip_before_filter :authenticate

          def show
            @video = Video.find(params.require(:id))
          end
        end
      end
    end
  end
end
