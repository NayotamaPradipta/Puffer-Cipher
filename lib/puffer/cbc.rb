require_relative 'base'
require_relative 'puffer_function'
module Puffer
    class Cbc < BaseCipher
        def encrypt(text)
            padded_text = pad(text)
            PufferFunction.initialize_p_array(@key)
            PufferFunction.initialize_s_box(@key)
            iv = random_iv()
            puts "IV: #{iv}"
            previous_block = iv

            encrypted_blocks = padded_text.chars.each_slice(BLOCK_SIZE).map(&:join).map do |block|
                block_binary = string_to_binary(block)
                block_xor = xor_blocks(block_binary, previous_block)
                encrypted_block = PufferFunction.f_function_encrypt(block_xor, key)
                previous_block = encrypted_block
                encrypted_block
            end

            encrypted_blocks.unshift(iv)
            puts "RESULT: #{encrypted_blocks.join}"
            encrypted_blocks.join
        end

        def decrypt(base64_text)
            PufferFunction.initialize_p_array(@key)
            PufferFunction.initialize_s_box(@key)

            binary_data = base64_to_binary(base64_text)
            iv, ciphertext = binary_data[0...128], binary_data[128..-1]
            previous_block = iv

            decrypted_blocks = ciphertext.chars.each_slice(BLOCK_SIZE*8).map(&:join).map do |block|
                decrypted_block = PufferFunction.f_function_decrypt(block, key)
                plaintext_block = xor_blocks(decrypted_block, previous_block)
                previous_block = block
                plaintext_block
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
    end
end
