module Puffer
    class BaseCipher 
        attr_reader :key 

        def initialize(key)
            @key = key 
        end 

        def encrypt(data)
            raise NotImplementedError, 'Subclass must implement the encryption method'
        end 

        def decrypt(data)
            raise NotImplementedError, 'Subclass must implement the decryption method'
        end 
    end 
end