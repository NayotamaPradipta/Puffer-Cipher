require_relative 'base'
require_relative 'puffer_function'
module Puffer
    class Ecb < BaseCipher
        def encrypt(text)
            padded_text = pad(text)
            PufferFunction.initialize_p_array(@key)
            PufferFunction.initialize_s_box(@key)
            encrypted_blocks = padded_text.chars.each_slice(BLOCK_SIZE).map(&:join).map do |block|
                block_binary = string_to_binary(block)
                encrypted_binary = PufferFunction.f_function_encrypt(block_binary, key)
            end
            encrypted_blocks.join
        end

        def decrypt(base64_text)
            PufferFunction.initialize_p_array(@key)
            PufferFunction.initialize_s_box(@key)
            binary_data = base64_to_binary(base64_text)
            puts "BINARY DATA: #{binary_data}"
            decrypted_blocks = binary_data.chars.each_slice(BLOCK_SIZE*8).map(&:join).map do |block|
                decrypted_binary = PufferFunction.f_function_decrypt(block, key)
            end 
            decrypted_blocks.join
        end
    end 
end