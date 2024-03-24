require_relative 'base'
require_relative 'puffer_function'
module Puffer
    class Cfb < BaseCipher
        attr_reader :r_size 
        def initialize(key, r_size = 1)
            super(key)
            @r_size = r_size
        end 
        def encrypt(text)
            PufferFunction.initialize_p_array(@key)
            PufferFunction.initialize_s_box(@key)
            iv = random_iv()
            shift_register = iv
            puts "R_SIZE: #{@r_size}"
            total_blocks = text.chars.each_slice(@r_size).map(&:join).size
            encrypted_blocks = text.chars.each_slice(@r_size).map(&:join).each_with_index.map do |block,index|
                block_encryptor = PufferFunction.f_function_encrypt(shift_register, key)[0...(@r_size*8)]
                block_binary = string_to_binary(block)
                encrypted_block = xor_blocks(block_encryptor, block_binary)
                shift_register = shift(shift_register,encrypted_block,@r_size)
                puts "Encrypted block #{index+1} of #{total_blocks}"
                encrypted_block
            end

            encrypted_blocks.unshift(iv)
            encrypted_blocks.join
        end

        def decrypt(base64_text)
            PufferFunction.initialize_p_array(@key)
            PufferFunction.initialize_s_box(@key)

            binary_data = base64_to_binary(base64_text)
            iv, ciphertext = binary_data[0...128], binary_data[128..-1]
            shift_register = iv
            total_blocks = ciphertext.chars.each_slice(@r_size*8).map(&:join).size
            decrypted_blocks = ciphertext.chars.each_slice(@r_size*8).map(&:join).each_with_index.map do |block,index|
                block_decryptor = PufferFunction.f_function_encrypt(shift_register, key)[0...(@r_size*8)]
                decrypted_block = xor_blocks(block_decryptor, block)
                shift_register = shift(shift_register,block,@r_size)
                puts "Encrypted block #{index+1} of #{total_blocks}"
                decrypted_block
            end

            decrypted_blocks.join
        end

        def random_iv(length=128)
            iv = ""
            length.times { iv << rand(2).to_s }
            iv
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
