require_relative 'base'
require_relative 'puffer_function'
module Puffer
    class Ecb < BaseCipher
        def encrypt(text)
            padded_text = pad(text)
            PufferFunction.initialize_p_array()
            PufferFunction.initialize_s_box()
            encrypted_blocks = padded_text.chars.each_slice(BLOCK_SIZE).map(&:join).map do |block|
                block_binary = string_to_binary(block)
                key_binary = string_to_binary(@key)
                encrypted_binary = PufferFunction.f_function_encrypt(block_binary, key_binary)
            end
            encrypted_blocks.join
        end

        def decrypt(base64_text)
            PufferFunction.initialize_p_array()
            PufferFunction.initialize_s_box()
            binary_data = base64_to_binary(base64_text)
            puts "BINARY DATA: #{binary_data}"
            decrypted_blocks = binary_data.chars.each_slice(BLOCK_SIZE*8).map(&:join).map do |block|
                key_binary = string_to_binary(@key)
                decrypted_binary = PufferFunction.f_function_decrypt(block, key_binary)
            end 
            decrypted_blocks.join
        end
    end 
end