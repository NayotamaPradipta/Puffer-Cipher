require_relative 'base'
require_relative 'puffer_function'
module Puffer
    class Ofb < BaseCipher
        attr_reader :r_size 
        def initialize(key, r_size = 1)
            super(key)
            @r_size = r_size
        end 
        def encrypt(text)
            PufferFunction.initialize_p_array(@key)
            PufferFunction.initialize_s_box(@key)
            shift_register = "0"*128 # Shift register innit with zeroes
            total_blocks = text.chars.each_slice(@r_size).map(&:join).size
            encrypted_blocks = text.chars.each_slice(@r_size).map(&:join).each_with_index.map do |block, index|
                block_encryptor = PufferFunction.f_function_encrypt(shift_register, key)[0...(@r_size*8)]
                block_binary = string_to_binary(block)
                encrypted_block = xor_blocks(block_encryptor, block_binary)
                shift_register = shift(shift_register,block_encryptor,@r_size)
                puts "Encrypted block #{index+1} of #{total_blocks}"
                encrypted_block
            end

            encrypted_blocks.join
        end

        def decrypt(base64_text)
            PufferFunction.initialize_p_array(@key)
            PufferFunction.initialize_s_box(@key)

            binary_data = base64_to_binary(base64_text)
            shift_register = "0"*128 # Shift register innit with zeroes
            total_blocks = binary_data.chars.each_slice(@r_size*8).map(&:join).size
            decrypted_blocks = binary_data.chars.each_slice(@r_size*8).map(&:join).each_with_index.map do |block,index|
                block_decryptor = PufferFunction.f_function_encrypt(shift_register, key)[0...(@r_size*8)]
                decrypted_block = xor_blocks(block_decryptor, block)
                shift_register = shift(shift_register,block_decryptor,@r_size)
                puts "Decrypted block #{index+1} of #{total_blocks}"
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
