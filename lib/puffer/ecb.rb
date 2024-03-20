require_relative 'base'
require_relative 'encryption_function'
module Puffer
    class Ecb < BaseCipher
        def encrypt(text)
            padded_text = pad(text)
            encrypted_blocks = padded_text.chars.each_slice(BLOCK_SIZE).map(&:join).map do |block|
                block_binary = string_to_binary(block)
                key_binary = string_to_binary(@key)
                encrypted_binary = EncryptionFunction.f_function(block_binary, key_binary)
            end
            encrypted_blocks.join
        end

        def decrypt(text)
            binary = string_to_binary(text)
            binary
        end
    end 
end