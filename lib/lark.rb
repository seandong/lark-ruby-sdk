require "lark/version"
require 'redis'
require 'active_support/all'
require 'lark/config'
require 'lark/cipher'
require 'lark/helper'

LIB_PATH = "#{File.dirname(__FILE__)}/lark"
Dir["#{LIB_PATH}/apis/**/*.rb",  "#{LIB_PATH}/token_store/*.rb"].each { |path| require path }

require 'lark/api'

module Lark
  API_BASE_URL = 'https://open.feishu.cn/open-apis/'.freeze

  # Exceptions
  class RedisNotConfigException < RuntimeError; end
  class AppNotConfigException < RuntimeError; end
  class AccessTokenExpiredError < RuntimeError; end
  class ResultErrorException < RuntimeError; end
  class ResponseError < StandardError
    attr_reader :error_code
    def initialize(errcode, errmsg='')
      @error_code = errcode
      super "(#{error_code}) #{errmsg}"
    end
  end
end
