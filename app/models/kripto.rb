class Kripto
    def self.encrypt(text, mode, key)
        cipher = get_cipher(mode, key)
        cipher ? cipher.encrypt(text) : "Unsupported Mode"
    end

    def self.decrypt(text, mode, key)
        cipher = get_cipher(mode, key)
        cipher ? cipher.decrypt(text) : "Unsupported Mode"
    end

    def self.get_cipher(mode, key)
        case mode
        when 'ecb'
            Puffer::Ecb.new(key)
        when 'cbc'
            Puffer::Cbc.new(key)
        when 'ofb'
            Puffer::Ofb.new(key)
        when 'cfb'
            Puffer::Cfb.new(key)
        when 'counter'
            Puiffer::Counter.new(key)
        else 
            nil 
        end 
    end
            


end
