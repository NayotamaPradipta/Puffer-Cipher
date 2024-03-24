class Kripto
    def self.encrypt(text, mode, key, options={})
        cipher = get_cipher(mode, key, options)
        cipher ? cipher.encrypt(text) : "Unsupported Mode"
    end

    def self.decrypt(text, mode, key, options={})
        cipher = get_cipher(mode, key, options)
        cipher ? cipher.decrypt(text) : "Unsupported Mode"
    end

    def self.get_cipher(mode, key, options={})
        case mode
        when 'ecb'
            Puffer::Ecb.new(key)
        when 'cbc'
            Puffer::Cbc.new(key)
        when 'ofb'
            Puffer::Ofb.new(key, options[:r])
        when 'cfb'
            Puffer::Cfb.new(key, options[:r])
        when 'counter'
            Puffer::Counter.new(key)
        else 
            nil 
        end 
    end
end
