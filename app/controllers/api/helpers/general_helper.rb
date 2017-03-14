module API::Helpers::GeneralHelper

	def error_message(e)
        @error = {}
        @error['code'] = e.try(:code) || 02
        @error['type'] = e.try(:type) || 'error'
        @error['message'] = e.try(:message) || 'Some error occurred'
        @status_code = e.try(:status) || API::Exceptions::INTERNAL_SERVER_ERROR
    end
	
	def declared_params
		declared(params, include_missing: false)
	end
end