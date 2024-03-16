require_relative 'base'
require_relative 'encryption_function'
module Puffer 
    class Cbc < BaseCipher
        def encrypt(text)
            "Encrypted #{text} with key #{@key} in CBC mode"
        end

        def decrypt(text)
            "Decrypted #{text} with key #{@key} in CBC mode"
        end
    end 
end