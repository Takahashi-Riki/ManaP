# If password is shorter than 32 characters, make it 32characters.
def change_password_32bytes(password)
  (password.chomp*6)[0..31]
end

# Make string to digest
def digest(string)
  Digest::MD5.hexdigest(string)
end

# Check whether key exist.
def check_key_existence
  File.open("./config/key.txt"){|f|
    key_digest = f.gets
    if key_digest.nil?
      puts <<~MESSAGE
        =============================================
        Hello, this is the first time I've met you.
        Let's set your key. Key is needed to manage your passwords.
      MESSAGE
      while true do
        print ">"
        inputed_key = gets.chomp
        if inputed_key.size < 6 || inputed_key.size > 32
          puts "ERROR: Key must be at least 6 characters and less than 33 characters."
          next
        else
          break
        end
      end
      File.open("./config/key.txt", mode = "w"){|f|
        f.write(digest(inputed_key))
      }
      
    else
      puts "Please type your key."
      while true do
        print ">"
        inputed_key = gets.chomp
        key_digest = ""
        File.open("./config/key.txt"){|f|
          key_digest = f.gets
        }
        if key_digest != digest(inputed_key)
          puts "ERROR: Please type your correct key."
          next
        else
          break
        end
      end
    end
    puts "NOTICE: OK."
    ::ActiveSupport::MessageEncryptor.new(change_password_32bytes(inputed_key), cipher: 'aes-256-cbc')
  }
end