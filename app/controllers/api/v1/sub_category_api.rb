module API::V1
  class SubCategoryApi < Grape::API

    resource :sub_category  do
      

      desc 'get list of sub categories'
      get do
        categories = SubCategory.all
        present categories, with: API::V1::Entities::SubCategoryEntity::SubCategoryList
      end

      desc ' list of sub categories'
      params do
        requires :id, type: Integer, desc: 'Category Id'
      end
      get ':id' do
        sub_category = SubCategory.find(params[:id].to_i)
        present sub_category, with: API::V1::Entities::SubCategoryEntity::SubCategoryList
      end

      desc 'Update Sub Category'
      params do
        requires :id, type: Integer
        optional :name, type: String
        optional :status, type: String
        optional :category_id, type:Integer
      end
      patch ':id' do
        sub_category = SubCategory.find(params[:id].to_i)
        unless sub_category.save!
          raise API::Exceptions::UnprocessableEntity.new(sub_category.errors.map{ |k,v| "#{k} #{v}"}.join(","))
        end
        present sub_category, with: API::V1::Entities::SubCategoryEntity::SubCategoryList
      end

      desc 'Add Sub Category'
      params do
        requires :name, type: String
        requires :status, type: String
        requires :category_id, type:Integer
      end
      post do
        sub_category = SubCategory.new(declared_params)
        unless sub_category.save!
          raise API::Exceptions::UnprocessableEntity.new(sub_category.errors.map{ |k,v| "#{k} #{v}"}.join(","))
        end
        present sub_category, with: API::V1::Entities::SubCategoryEntity::SubCategoryList
      end

    end
  end
end
