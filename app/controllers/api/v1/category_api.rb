module API::V1
  class CategoryApi < Grape::API

    resource :category  do
      

      desc 'get list of categories'
      get do
        categories = Category.all
        present categories, with: API::V1::Entities::CategoryEntity::CategoryList
      end

      desc ' list of categories'
      params do
        requires :id, type: Integer, desc: 'Category Id'
      end
      get ':id' do
        category = Category.find(params[:id].to_i)
        present category, with: API::V1::Entities::CategoryEntity::CategoryList
      end

      desc 'Update Category'
      params do
        requires :id, type: Integer
        optional :name, type: String
        optional :status, type: String
      end
      patch ':id' do
        category = Category.find(params[:id].to_i)
        unless category.save!
          raise API::Exceptions::UnprocessableEntity.new(category.errors.map{ |k,v| "#{k} #{v}"}.join(","))
        end
        present category, with: API::V1::Entities::CategoryEntity::CategoryList
      end

      desc 'Add Category'
      params do
        requires :name, type: String
        requires :status, type: String
      end
      post do
        category = Category.new(declared_params)
        unless category.save!
          raise API::Exceptions::UnprocessableEntity.new(category.errors.map{ |k,v| "#{k} #{v}"}.join(","))
        end
        present category, with: API::V1::Entities::CategoryEntity::CategoryList
      end

    end
  end
end
