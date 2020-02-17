require 'openssl/cipher'
require 'base64'

module Lark
  module Cipher
    def decrypt(key, message)
      cipher = OpenSSL::Cipher.new('AES-256-CBC')
      cipher.decrypt

      decode64 = Base64.urlsafe_decode64(message)
      iv = decode64[0..15]
      ecrypted = decode64[16..-1]

      cipher.key = Digest::SHA256.digest(key)
      cipher.iv = iv
      cipher.update(ecrypted) + cipher.final
    end
  end
end