module API
  module Exceptions

    BAD_REQUEST             = 400
    AUTHENTICATION_FAILED   = 401
    UNAUTHORIZED            = 403
    NOT_FOUND               = 404
    UNPROCESSABLE_ENTITY    = 422
    INTERNAL_SERVER_ERROR   = 500

    class BaseError < StandardError
      attr_reader :message, :code, :type, :status
      def initialize(message, code, status, type)
        @message = message
        @code = code
        @type = type
        @status = status
      end
    end

    class AuthorizationError < BaseError
      def initialize(message = 'Not Authorized')
        super(message, 10, UNAUTHORIZED, 'authentication')
      end
    end

    class AuthenticationError < BaseError
      def initialize(message = 'Authentication Failed')
        super(message, 10, AUTHENTICATION_FAILED, 'authentication')
      end
    end

    class UnprocessableEntity < BaseError
      def initialize(message = 'Unprocessable Entity')
        super(message, 15, UNPROCESSABLE_ENTITY, 'error')
      end
    end

    class ResourceNotFound < BaseError
      def initialize(message = 'Resource Not Found')
        super(message, 21, NOT_FOUND, 'error')
      end
    end

    class InsufficientPrivilege < BaseError
      def initialize(message = 'Insufficient privilege')
        super(message, 29, UNPROCESSABLE_ENTITY, 'error')
      end
    end

  end
end