module API
	class Root < Grape::API
		prefix 'api'
		version 'v1'
		helpers API::Helpers::GeneralHelper
		use Middleware::Logger
		rescue_from Grape::Exceptions::ValidationErrors do |e|
	      error_message(e)
	      error!({error: @error}, API::Exceptions::BAD_REQUEST)
	    end
	    mount API::V1::Root
	end
end