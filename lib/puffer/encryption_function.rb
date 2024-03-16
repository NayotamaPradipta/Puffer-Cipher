module EncryptionFunction
    # Modul untuk fungsi yang sama untuk semua mode 
    def self.f_function(block, key)
        # TODO: Initialize P-array, S-boxes with Hexadecimal pi 
        #       Implement Key Scheduling Algorithm
        #       Implement Feistel Network
        block ^ key
    end 
end 