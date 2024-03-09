class Kripto
    def self.encrypt(text, mode, key)
        case mode
        when 'ecb'
            Puffer::Ecb.encrypt(text, key)
        when 'cbc'
            Puffer::Cbc.encrypt(text, key)
        when 'ofb'
            Puffer::Ofb.encrypt(text, key)
        when 'cfb'
            Puffer::Cfb.encrypt(text, key)
        when 'counter'
            Puffer::Counter.encrypt(text, key)
        else
            "Unsupported Mode"
        end
    end

    def self.decrypt(text, mode, key)
        case mode
        when 'ecb'
            Puffer::Ecb.decrypt(text, key)
        when 'cbc'
            Puffer::Cbc.decrypt(text, key)
        when 'ofb'
            Puffer::Ofb.decrypt(text, key)
        when 'cfb'
            Puffer::Cfb.decrypt(text, key)
        when 'counter'
            Puffer::Counter.decrypt(text, key)
        else
            "Unsupported Mode"
        end
    end
end
