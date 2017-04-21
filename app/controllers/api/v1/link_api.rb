module API::V1
  class LinkApi < Grape::API

    resource :link  do
      

      desc 'get list of all links'
      get do
        links = Link.all
        present links, with: API::V1::Entities::LinkEntity::LinkList
      end

      desc 'get a single link links'
      params do
        requires :id, type: Integer
      end
      get ':id' do
        params = declared_params
        link = Link.find(params[:id])
        raise ActiveRecord::RecordNotFound unless link.present?
        present links, with: API::V1::Entities::LinkEntity::LinkList
      end


      desc 'Add a link'
      params do
        requires :name, type: String
        requires :status, type: String
        requires :category_id, type: Integer
        requires :url, type:String
        optional :description, type: String
        optional :link_type, type: String
      end
      post do
        link = Link.new(declared_params)
        unless link.save!
          raise API::Exceptions::UnprocessableEntity.new(link.errors.map{ |k,v| "#{k} #{v}"}.join(","))
        end
        present link, with: API::V1::Entities::LinkEntity::LinkList
      end

      desc 'update a link'
      params do
        requires :id, type: Integer
        optional :name, type: String
        optional :status, type: String
        optional :category_id, type: Integer
        optional :url, type:String
        optional :description, type: String
        optional :link_type, type: String
      end
      patch do
        params = declared_params
        link = Link.find(params[:id])
        raise ActiveRecord::RecordNotFound unless link.present?
        unless link.update!(params)
          raise API::Exceptions::UnprocessableEntity.new(link.errors.map{ |k,v| "#{k} #{v}"}.join(","))
        end
        present link, with: API::V1::Entities::LinkEntity::LinkList
      end

      desc 'delete a link'
      params do
        requires :id, type: Integer
      end
      delete do
        params = declared_params
        link = Link.find(params[:id])
        raise ActiveRecord::RecordNotFound unless link.present?
        unless link.destroy!
          raise API::Exceptions::UnprocessableEntity.new(link.errors.map{ |k,v| "#{k} #{v}"}.join(","))
        end
        present {success:true}
      end

    end
  end
end