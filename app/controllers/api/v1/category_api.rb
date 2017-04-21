module API::V1
  class CategoryApi < Grape::API

    resource :category  do
      

      desc 'get list of categories'
      get do
        categories = Category.all
        present categories, with: API::V1::Entities::CategoryEntity::CategoryList
      end

      desc 'get all nested categories'
      params do
        requires :id, type: Integer, desc: 'Category Id'
      end
      get ':id/full_tree' do
        category = Category.find(params[:id].to_i)
        raise ActiveRecord::RecordNotFound unless category.present?
        all_desendends = category.self_and_descendents
        present all_desendends, with: API::V1::Entities::CategoryEntity::FullTreeList
      end
      
      desc 'get a single category'
      params do
        requires :id, type: Integer, desc: 'Category Id'
      end
      get ':id' do
        category = Category.find(params[:id].to_i)
        raise ActiveRecord::RecordNotFound unless category.present?
        present category, with: API::V1::Entities::CategoryEntity::CategoryList
      end

      desc 'Add Category'
      params do
        requires :name, type: String
        requires :status, type: String
        optional :parent_id, type: Integer
      end
      post do
        category = Category.new(declared_params)
        unless category.save!
          raise API::Exceptions::UnprocessableEntity.new(category.errors.map{ |k,v| "#{k} #{v}"}.join(","))
        end
        present category, with: API::V1::Entities::CategoryEntity::CategoryList
      end

      desc 'update Category'
      params do
        requires :id, type: Integer
        optional :name, type: String
        optional :status, type: String
        optional :parent_id, type: Integer
      end
      patch do
        params = declared_params
        category = Category.find(params[:id])
        raise ActiveRecord::RecordNotFound unless category.present?
        unless category.update!(params)
          raise API::Exceptions::UnprocessableEntity.new(category.errors.map{ |k,v| "#{k} #{v}"}.join(","))
        end
        present category, with: API::V1::Entities::CategoryEntity::CategoryList
      end

      desc 'get all links of an category'
      params do
        requires :category_id, type: Integer, desc: 'Category Id'
      end
      get ':category_id/links' do
        params = declared_params
        links = Link.where(category_id: params[:category_id]);
        present links, with: API::V1::Entities::LinkEntity::LinkList
      end


    end
  end
end
