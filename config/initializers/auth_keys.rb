AUTH_PUBLIC_KEY = OpenSSL::PKey::RSA.new(File.read('./config/public_key.pem'))
