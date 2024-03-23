require_relative 'base'
require_relative 'puffer_function'
module Puffer
    class Counter < BaseCipher
        def encrypt(text)
            padded_text = pad(text)
            PufferFunction.initialize_p_array(@key)
            PufferFunction.initialize_s_box(@key)
            counter = generate_counter(key)
            puts "counter innit: #{counter}"

            encrypted_blocks = padded_text.chars.each_slice(BLOCK_SIZE).map(&:join).map do |block|
                block_encryptor = PufferFunction.f_function_encrypt(counter, key)
                block_binary = string_to_binary(block)
                counter = update(counter)
                encrypted_block = xor_blocks(block_encryptor, block_binary)
            end
            encrypted_blocks.join
        end

        def decrypt(base64_text)
            PufferFunction.initialize_p_array(@key)
            PufferFunction.initialize_s_box(@key)
            binary_data = base64_to_binary(base64_text)
            counter = generate_counter(key)
            puts "counter innit: #{counter}"

            decrypted_blocks = binary_data.chars.each_slice(BLOCK_SIZE*8).map(&:join).map do |block|
                block_decryptor = PufferFunction.f_function_encrypt(counter, key)
                counter = update(counter)
                decrypted_block = xor_blocks(block_decryptor, block)
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

        def update(counter)
            counter_i = counter.to_i(2)
            if counter_i >= 2**128 - 1
              return "0" * 128
            end

            counter_i += 1
            new_counter = counter_i.to_s(2)
            new_counter = new_counter.rjust(128, '0')
        end

        private

        def generate_counter(key, length=128)
            counter = (key.length*8 + key.length*16)**4
            counter_binary = counter.to_s(2).rjust(length, '0')
            counter_binary[-length..-1]
        end
    end
end
