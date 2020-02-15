require "lark/version"
require 'redis'
require 'active_support/all'

module Lark
  API_BASE_URL = 'https://open.feishu.cn/open-apis/'.freeze

  # Exceptions
  class RedisNotConfigException < RuntimeError; end
  class TenantAccessTokenExpiredError < RuntimeError; end
  class AppAccessTokenExpiredError < RuntimeError; end
  class ResultErrorException < RuntimeError; end
  class ResponseError < StandardError
    attr_reader :error_code
    def initialize(errcode, errmsg='')
      @error_code = errcode
      super "(#{error_code}) #{errmsg}"
    end
  end
end
