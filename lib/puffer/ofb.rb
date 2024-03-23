require_relative 'base'
require_relative 'puffer_function'
module Puffer
    class Ofb < BaseCipher
        def encrypt(text)
            r_size = 1 # 8-bit / 1-byte OFB by default
            PufferFunction.initialize_p_array(@key)
            PufferFunction.initialize_s_box(@key)
            shift_register = "0"*128 # Shift register innit with zeroes

            encrypted_blocks = text.chars.each_slice(r_size).map(&:join).map do |block|
                block_encryptor = PufferFunction.f_function_encrypt(shift_register, key)[0...(r_size*8)]
                block_binary = string_to_binary(block)
                encrypted_block = xor_blocks(block_encryptor, block_binary)
                shift_register = shift(shift_register,block_encryptor,r_size)
                encrypted_block
            end

            encrypted_blocks.join
        end

        def decrypt(base64_text)
            r_size = 1 # 8-bit / 1-byte OFB by default
            PufferFunction.initialize_p_array(@key)
            PufferFunction.initialize_s_box(@key)

            binary_data = base64_to_binary(base64_text)
            shift_register = "0"*128 # Shift register innit with zeroes

            decrypted_blocks = binary_data.chars.each_slice(r_size*8).map(&:join).map do |block|
                block_decryptor = PufferFunction.f_function_encrypt(shift_register, key)[0...(r_size*8)]
                decrypted_block = xor_blocks(block_decryptor, block)
                shift_register = shift(shift_register,block_decryptor,r_size)
                decrypted_block
            end

            decrypted_blocks.join
        end

        def xor_blocks(block1, block2)
            result = ""
            block1.length.times do |i|
              result << (block1[i].to_i ^ block2[i].to_i).to_s
            end
            result
        end

        def shift(shift_register, new_bits, r_size)
            shifted_register = shift_register[(r_size*8)..-1] + new_bits
        end
    end
end
