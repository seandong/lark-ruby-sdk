module Lark
  # Exceptions
  class RedisNotConfigException < RuntimeError; end
  class AppNotConfigException < RuntimeError; end
  class AccessTokenExpiredError < RuntimeError; end
  class ResultErrorException < RuntimeError; end
  class InternalErrorException < RuntimeError; end
  class ServerErrorException < RuntimeError; end
  class ResponseError < StandardError
    attr_reader :error_code
    def initialize(errcode, errmsg='')
      @error_code = errcode
      super "(#{error_code}) #{errmsg}"
    end
  end
end
