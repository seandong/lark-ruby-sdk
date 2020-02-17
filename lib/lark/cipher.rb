require 'openssl/cipher'
require 'base64'

module Lark
  class Cipher
    attr_reader :key

    CIPHER = 'AES-256-CBC'.freeze

    def initialize(key)
      @key = Digest::SHA256.digest(key)
    end

    def encrypt(message)
      cipher = OpenSSL::Cipher.new(CIPHER)
      cipher.encrypt
      cipher.key = key
      iv = cipher.random_iv
      Base64.urlsafe_encode64(iv + cipher.update(message) + cipher.final)
    end

    def decrypt(message)
      cipher = OpenSSL::Cipher.new(CIPHER)
      cipher.decrypt

      decode64 = Base64.urlsafe_decode64(message)
      cipher.key = key
      cipher.iv = decode64[0..15]
      ecrypted = decode64[16..-1]
      cipher.update(ecrypted) + cipher.final
    end

  end
end
