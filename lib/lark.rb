require "lark/version"
require 'redis'
require 'active_support/all'
require 'lark/config'
require 'lark/cipher'
require 'lark/helper'

lib_path = "#{File.dirname(__FILE__)}/lark"
Dir["#{lib_path}/apis/**/*.rb",  "#{lib_path}/token_store/*.rb"].each { |path| require path }

require 'lark/api'

module Lark
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
