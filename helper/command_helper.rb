require './constant.rb'

# Accept a command from console
def accept_command
  print ">"
  convert_command(gets.chomp)
end

# Convert a command to a hash
def convert_command(inputed_command_args)
  prepared_command_list = {
    exit: {id:1, necessary_args:0},
    manual: {id:2, necessary_args:0},
    reset: {id:3, necessary_args:1,},
    show: {id:4, necessary_args:0},
    register: {id:5, necessary_args:3},
    delete: {id:6, necessary_args:1}
  }
  inputed_command = inputed_command_args.split[0].to_sym
  inputed_args = inputed_command_args.split[1..]
  converted_command = {status: nil, command_with_args: nil, message: nil}
  if !prepared_command_list.keys.include?(inputed_command)
    converted_command[:status] = 0
    converted_command[:message] = Constant::Error::COMMAND_NOT_ACCEPTED_MESSAGE
  elsif prepared_command_list[inputed_command][:necessary_args] != inputed_args.size
    converted_command[:status] = 0
    converted_command[:message] = Constant::Error::INVALID_ARGS_TO_COMMAND_MESSAGE
  else
    converted_command[:status] = 1
    converted_command[:command_with_args] = {command: inputed_command, args: inputed_args}
  end
  return converted_command
end