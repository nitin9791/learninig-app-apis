module API::V1::Entities
  module LinkEntity
   
    class LinkList < Grape::Entity
      root 'links','link'
      expose :id, :name, :status,:category_id,:link_type,:url,:description
    end 
    
  end
end