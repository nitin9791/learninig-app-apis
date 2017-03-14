module API
  module Middleware

    class Logger < Grape::Middleware::Base

      def initialize(app, options = {})
        super
      end

      def before
        start_time
      end

      def after(status)
        stop_time
        parameters(request, status)
      end

      def after_exception(e)
        stop_time
        exception_uniq_id = ('A'..'Z').to_a.sample(6).join + (0..9).to_a.sample(6).join
        error_string = "RuntimeError :: #{exception_uniq_id}"
        if request.params.to_h.with_indifferent_access[:dev_debug] == 'true'
          error_string << e.backtrace.join("\n")
        elsif !Rails.env.production?
          error_string << e.backtrace[0..10].join("\n")
        end
        if e.class.to_s.starts_with?("API::Exceptions")
          log_params = after_failure({:message => e.message, :status => e.status})
          log_params[:message] = e.message
          Rails.logger.info "#{e.class} :: #{exception_uniq_id} :: #{log_params}"
        elsif e.class.to_s == 'Grape::Exceptions::ValidationErrors'
          log_params = after_failure({:message => e.message, :status => API::Exceptions::BAD_REQUEST})
          log_params[:message] = e.message
          Rails.logger.error "ValidationError :: #{exception_uniq_id} :: #{log_params}"
        elsif e.class.to_s == 'ApiService::Exceptions::InternalApiServiceError'
          log_params = after_failure({:message => e.message, :status => API::Exceptions::INTERNAL_SERVER_ERROR})
          log_params[:message] = e.message
          Rails.logger.error "InternalServiceError :: #{exception_uniq_id} :: #{log_params}"
          Rails.logger.error error_string
        else
          log_params = after(API::Exceptions::INTERNAL_SERVER_ERROR)
          log_params[:message] = e.message
          Rails.logger.error "InternalError :: #{exception_uniq_id} :: #{log_params}"
          Rails.logger.error error_string
        end
      end

      def after_failure(error)
        after(error[:status])
      end

      def call!(env)
        @env = env
        before
        error = catch(:error) do
          begin
            @app_response = @app.call(@env)
          rescue => e
            after_exception(e)
            raise e
          end
          nil
        end
        if error
          after_failure(error)
          throw(:error, error)
        else
          status, _, _ = *@app_response
          after(status)
        end
        @app_response
      end

      private

      def parameters(request, status)
        {
            path:          request.path,
            params:        request.params.to_hash,
            method:        request.request_method,
            total_time:    total_runtime,
            status:        status
        }
      end

      def request
        @request ||= ::Rack::Request.new(env)
      end

      def total_runtime
        ((stop_time - start_time) * 1000).round(2)
      end

      def start_time
        @start_time ||= Time.now
      end

      def stop_time
        @stop_time ||= Time.now
      end
    end

  end
end