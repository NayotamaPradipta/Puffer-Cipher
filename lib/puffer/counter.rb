require_relative 'base'
require_relative 'encryption_function'
module Puffer 
    class Counter < BaseCipher
        def encrypt(text)
            "Encrypted #{text} with key #{@key} in Counter mode"
        end

        def decrypt(text)
            "Decrypted #{text} with key #{@key} in Counter mode"
        end
    end 
end 