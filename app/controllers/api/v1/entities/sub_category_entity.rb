module API::V1::Entities
  module SubCategoryEntity
    class SubCategoryList < Grape::Entity
      root 'sub_categories','sub_category'
      expose :id, :name, :status
      expose :category, with: API::V1::Entities::CategoryEntity::CategoryList
    end
  end
end