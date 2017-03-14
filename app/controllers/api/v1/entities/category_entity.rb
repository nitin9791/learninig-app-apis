module API::V1::Entities
  module CategoryEntity
    class CategoryList < Grape::Entity
      root 'categories','category'
      expose :id, :name, :status
    end
  end
end