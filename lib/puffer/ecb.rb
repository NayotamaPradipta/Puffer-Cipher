require_relative 'base'
require_relative 'encryption_function'
module Puffer
    class Ecb < BaseCipher
        def encrypt(text)
            "Encrypted #{text} with key #{@key} in ECB mode"
        end

        def decrypt(text)
            "Decrypted #{text} with key #{@key} in ECB mode"
        end
    end 
end