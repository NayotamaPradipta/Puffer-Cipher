module Puffer
    class BaseCipher 
        attr_reader :key 

        BLOCK_SIZE = 16 # 16 bytes / 128 bits

        def initialize(key)
            @key = key 
        end 

        def encrypt(data)
            raise NotImplementedError, 'Subclass must implement the encryption method'
        end 

        def decrypt(data)
            raise NotImplementedError, 'Subclass must implement the decryption method'
        end 

        private 

        def pad(data)
            # Add padding if text block is less than 128 bit
        end

        def to_binary(data)
            data.force_encoding('ASCII-8BIT')
        end 

        def string_to_binary(str)
            str.bytes.map { |b| b.to_s(2).rjust(8, '0')}.join
        end
    end 
end