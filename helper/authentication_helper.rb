require './constant.rb'

# If key is shorter than 32 characters, make it 32characters.
def change_key_to_32bytes(key)
  (key.chomp*6)[0..31]
end

# Make string to digest
def digest(string)
  Digest::MD5.hexdigest(string)
end

# Check the inputed key is valid. If so, return it.
def authenticate_key(inputed_key)
  key_digest = ""
  File.open("./config/key.txt"){|f|
    key_digest = f.gets
  }
  key_digest == digest(inputed_key) ? inputed_key : nil
end

# Accept a key and check the key is valid.
def accepted_existing_key
  puts Constant::Authentication::ACCEPT_KEY_MESSAGE
  while true do
    print ">"
    inputed_key = gets.chomp
    if authenticated_key = authenticate_key(inputed_key)
      break
    else
      puts Constant::Error::PASSWORD_NOT_ACCEPTED_MESSAGE
      next
    end
  end
  return authenticated_key
end

# Generate new key.
def generated_new_key
  puts Constant::Authentication::FIRST_TIME_MESSAGE
  while true do
    print ">"
    inputed_key = gets.chomp
    if inputed_key.size < 6 || inputed_key.size > 32
      puts Constant::Error::PASSWORD_LENGTH_NOT_SUITABLE_MESSAGE
      next
    else
      break
    end
  end
  File.open("./config/key.txt", mode = "w"){|f|
    f.write(digest(inputed_key))
  }
  return inputed_key
end

# Check whether key exist.
def generate_encryptor_from_key
  File.open("./config/key.txt"){|f|
    key_digest = f.gets
    authenticated_key = key_digest.nil? ? generated_new_key : accepted_existing_key
    puts Constant::Success::OK_MESSAGE
    ::ActiveSupport::MessageEncryptor.new(change_key_to_32bytes(authenticated_key), cipher: 'aes-256-cbc')
  }
end