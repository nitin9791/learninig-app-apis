module API::V1::Entities
  module CategoryEntity
    class CategoryList < Grape::Entity
      root 'categories','category'
      expose :id, :name, :status, :parent_id
    end

	class FullTreeList < Grape::Entity
      root 'categories','category'
      expose :id, :name, :status, :parent_id
    end     

  end
end