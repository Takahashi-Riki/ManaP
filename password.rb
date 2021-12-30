require 'securerandom'
require 'active_support/all'
require 'csv'
require 'digest/md5'

require './helper/authentication_helper'
require './helper/command_helper'
require './helper/csv_helper'

# Print the logo.
puts <<LOGO

##    ##                            #### 
###  ##                             ## ##
###  ##    ###     ####     ###     ##  #
# # # #    #  #    ##  #    #  #    ## ##
#  ## #       #    #   #       #    #### 
#  #  #    ####    #   #    ####    ##   
#     #   ##  #    #   #   ##  #    ##   
##   ###   #####   ## ###   #####   ##   

LOGO

# Check key. If it is the first time to use, set key.
encryptor = check_key_existence

# Print greeting and usage.
puts <<~GREETING_AND_USAGE
  =============================================
  Please type commands.
  【Command List】
  Finish using              : exit
  See how to use            : manual
  Reset all data            : reset [your key]
  Show your passwords       : show
  Register a new password   : register [service name] [username] [password]
  Delete a existing password: delete  [service name]
  (eg. register FGmail hello@example.com a23s34d)
GREETING_AND_USAGE

# Accept commands until typed "exit".
while true do
  # Read password.csv
  password_csv = CSV.read('./config/password.csv', headers: true, encoding: "Shift_JIS:UTF-8")
  
  # Accept and convert a command.
  print ">"
  inputed_command = convert_command(gets.chomp)
  if inputed_command[:command].nil?
    puts inputed_command[:message]
    next
  end
  command_id = inputed_command[:command][:command_id]
  args_list = inputed_command[:command][:args]

  # Process a command.
  case command_id
  when 1
    puts "Thank you for using. Goodbye!"
    break
  when 2
    puts <<~MANUAL
      =============================================
      Q. What is ManaP?
      This application is made to manage your passwords with one password.

      Q. What is the "key"?
      You can manage all of your passwords with one password. The one password is the "key".

      Q. How to use?
      1. First of all, register your key. Maybe you already have done.
      2. You can manage your passwords with commands. When to type commands English can only be used.
      【Command List】
      Finish using              : exit
      See how to use            : manual
      Show your passwords       : show
      Register a new password   : register [service name] [username] [password]
      Delete a existing password: delete  [service name]
      (eg. register FGmail hello@example.com a23s34d)
    MANUAL
  when 3
    key_digest = ""
    File.open("./config/key.txt"){|f|
      key_digest = f.gets
    }
    if key_digest != digest(args_list[0])
      puts "ERROR: Please type your correct key."
      next
    else
      File.write("./config/key.txt", "")
      File.write("./config/password.csv", set_columns("string"))
      puts "NOTICE: Please restart."
      break
    end
  when 4
    puts "【Your Passwords】"
    make_table(password_csv, encryptor)
  when 5
    CSV.open("./config/password.csv", "a", encoding: "Shift_JIS:UTF-8") do |csv|
      register_information = []
      register_information << args_list[0]
      register_information << encryptor.encrypt_and_sign(args_list[1])
      register_information << encryptor.encrypt_and_sign(args_list[2])
      csv << register_information
    end
  when 6
    csv_table = CSV.table("./config/password.csv")
    csv_table.by_row!
    csv_table.delete_if{|row| row[:service] == args_list[0]}
    csv_table.each { |row| p row[:service] }
    File.write("./config/password.csv", csv_table)
  end
end