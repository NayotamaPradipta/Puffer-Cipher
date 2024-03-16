require_relative 'base'
require_relative 'encryption_function'
module Puffer
    class Ecb < BaseCipher
        def encrypt(text)
            binary = string_to_binary(text)
            binary
        end

        def decrypt(text)
            binary = string_to_binary(text)
            binary
        end
    end 
end