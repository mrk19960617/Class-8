# to encrypt a secret, use BCrypt::Password.create(secret)
# to test a secret, use BCrypt::Password.new(encrypted) == secret
# run this file using rails runner scripts/encryption.rb

# TODO:
# 1. encrypt a secret and puts encrypted string
secret = "Abcd7188!!"
puts secret
enctrypted_secret = BCrypt::Password.create(secret)
# 2. prepare encrypted string for testing
puts enctrypted_secret
# 3. test secret against prepared encrypted string
puts BCrypt::Password.new(enctrypted_secret) == "Abcd7188!!"
