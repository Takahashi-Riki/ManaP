require 'securerandom'
require 'active_support/all'
require 'csv'
require 'digest/md5'

require './model/service'

require './helper/authentication_helper'
require './helper/command_helper'
require './helper/csv_helper'

require './constant'

# Print the logo.
puts Constant::Greeting::LOGO

# Check key. If it is the first time to use, set key.
encryptor = generate_encryptor_from_key

# Print greeting and usage.
puts Constant::Usage::ACCEPT_COMMAND_MESSAGE

# Accept commands until typed "exit".
while true do
  # Read password.csv
  passwords_csv = CSV.read('./config/password.csv', headers: true, encoding: "Shift_JIS:UTF-8")

  # Set passwords list and ecryptor for passwords.
  Service.passwords_csv = passwords_csv
  Service.encryptor = encryptor
  
  # Accept and convert a command.
  inputed_command = accept_command
  if inputed_command[:status] != 1
    puts inputed_command[:message]
    next
  end
  command = inputed_command[:command_with_args][:command]
  args_list  = inputed_command[:command_with_args][:args]

  # Process a command.
  case command
  when :exit
    puts Constant::Greeting::FINISH_MESSAGE
    break
  when :manual
    puts Constant::Usage::MANUAL_MESSAGE
  when :reset
    inputed_key = args_list[0]
    if authenticate_key(inputed_key)
      File.write("./config/key.txt", "")
      File.write("./config/password.csv", get_columns("string"))
      puts Constant::Success::PASSWORD_SUCCESSFULLY_RESETED_MESSAGE
      break
    else
      puts Constant::Error::PASSWORD_NOT_ACCEPTED_MESSAGE
      next
    end
  when :show
    Service.show_all_passwords
  when :register
    service_name = args_list[0]
    username = encryptor.encrypt_and_sign(args_list[1])
    password = encryptor.encrypt_and_sign(args_list[2])
    service = Service.new(service_name, username, password)
    service.register_to_csv
  when :delete
    service_name = args_list[0]
    Service.delete_from_csv(service_name)
  end
end