# Convert command to hash
def convert_command(inputed_command_args)
  prepared_command_list = {
    exit: {id:1, necessary_args:0},
    manual: {id:2, necessary_args:0},
    reset: {id:3, necessary_args:1,},
    show: {id:4, necessary_args:0},
    register: {id:5, necessary_args:3},
    delete: {id:6, necessary_args:1}}
  inputed_command = inputed_command_args.split[0]
  inputed_args = inputed_command_args.split[1..]
  return_values = {status: nil, command: nil, message: nil}
  if !prepared_command_list.keys.include?(inputed_command.to_sym)
    return_values[:status] = 0
    return_values[:message] = "ERROR: Please type the suitable command."
    return return_values
  elsif prepared_command_list[inputed_command.to_sym][:necessary_args] != inputed_args.size
    return_values[:status] = 0
    return_values[:message] = "ERROR: Please type the required quantity of commands"
    return return_values
  else
    return_values[:status] = 1
    return_values[:command] = {command_id: prepared_command_list[inputed_command.to_sym][:id], args: inputed_args}
    return return_values
  end
end