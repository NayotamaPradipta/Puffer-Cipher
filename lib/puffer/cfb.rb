require_relative 'base'
require_relative 'puffer_function'
module Puffer
    class Cfb < BaseCipher
        def encrypt(text)
            r_size = 1 # 8-bit / 1-byte CFB by default
            PufferFunction.initialize_p_array(@key)
            PufferFunction.initialize_s_box(@key)
            iv = random_iv()
            shift_register = iv

            encrypted_blocks = text.chars.each_slice(r_size).map(&:join).map do |block|
                block_encryptor = PufferFunction.f_function_encrypt(shift_register, key)[0...(r_size*8)]
                block_binary = string_to_binary(block)
                encrypted_block = xor_blocks(block_encryptor, block_binary)
                shift_register = shift(shift_register,encrypted_block,r_size)
                encrypted_block
            end

            encrypted_blocks.unshift(iv)
            encrypted_blocks.join
        end

        def decrypt(text)
            "Decrypted #{text} with key #{@key} in CFB mode"
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
