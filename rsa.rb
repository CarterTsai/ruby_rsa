require "openssl"
require "base64"

privateKey = ""
publicKey = ""

def loadKey(filepath)
    key = ""
    File.open(filepath, "r") do |f|
        f.each_line do |line|
            key = key+ line
        end
        return key
    end
end

privateKey = loadKey("./private.pem")
publicKey = loadKey("./public.pem")

private_rsa_key = OpenSSL::PKey::RSA.new(privateKey)
public_rsa_key = OpenSSL::PKey::RSA.new(publicKey)

encryptString = Base64::encode64(public_rsa_key.public_encrypt("hello"))
puts "Encrypt String => "
puts encryptString
puts "====================================="

puts "Decrypt String => "
decryptString = private_rsa_key .private_decrypt Base64::decode64(encryptString)
puts decryptString
