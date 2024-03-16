require_relative 'base'
require_relative 'encryption_function'
module Puffer
    class Cfb < BaseCipher
        def encrypt(text)
            "Encrypted #{text} with key #{@key} in CFB mode"
        end

        def decrypt(text)
            "Decrypted #{text} with key #{@key} in CFB mode"
        end
    end 
end