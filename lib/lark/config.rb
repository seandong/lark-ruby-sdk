require 'logger'

module Lark
  class << self
    def configure
      yield config
    end

    def config
      @config ||= Config.new
    end

    def redis
      config.redis
    end

    def logger
      @logger ||= if config.logger.nil?
                    defined?(Rails) && Rails.logger ? Rails.logger : Logger.new(STDOUT)
                  else
                    config.logger
                  end
    end

    def http_timeout_options
      config.http_timeout_options || {write: 2, connect: 5, read: 10}
    end
  end

  class Config
    attr_accessor :app_id, :app_secret, :isv, :redis, :http_timeout_options, :logger
  end
end
