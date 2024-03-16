require_relative 'base'
require_relative 'encryption_function'
module Puffer
    class Ofb < BaseCipher
        def encrypt(text)
            "Encrypted #{text} with key #{@key} in OFB mode"
        end

        def decrypt(text)
            "Decrypted #{text} with key #{@key} in OFB mode"
        end
    end 
end 