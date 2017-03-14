module API
  module V1
    class Root < Grape::API
      version 'v1', using: :path

      format :json
      default_format :json
      content_type :json, 'application/json'
      mount API::V1::CategoryApi
      mount API::V1::SubCategoryApi
      # mount API::V1::LearningResourceApi
    end
  end
end