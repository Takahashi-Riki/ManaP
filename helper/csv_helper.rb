# Return most long word from a word_list.
def get_max_length(word_list)
  max_word = ""
  for i in 0..word_list.size-1 do
    max_word = word_list[i] if word_list[i].size >= max_word.size
  end
  return max_word.size
end

# Make a table from csv data using make_row() method.
def make_table(csv, encryptor)
  scale = 20
  columns = set_columns("array")
  make_row(columns, scale)
  puts_line("=", scale, columns.size)
  csv.each do |data|
    make_row([data["service"], encryptor.decrypt_and_verify(data["username"]), encryptor.decrypt_and_verify(data["password"])], scale)
    puts_line("-", scale, columns.size)
  end
end

# Make a row of a table.
def make_row(word_list, scale)
  number_of_lines = get_max_length(word_list) / scale + 1
  for i in 0..number_of_lines-1 do
    line = "|"
    for word in word_list do
      word_sliced = word[scale*i..scale*(i+1)-1].to_s
      line += word_sliced + " "*(scale-word_sliced.size) + "|"
    end
    puts line
  end
end

# Make a Ruled line.
def puts_line(mark, scale, columns_length)
  puts mark * (scale * columns_length + columns_length + 1)
end

# Get columns as string or array
def set_columns(format)
  column_list = ["service", "username", "password"]
  case format
  when "string"
    column_list.join(",") + "\n"
  when "array"
    column_list
  end
end

# Get columns as string or array
def get_columns(csv, format)
  column_list = []
  for array in csv[0].to_a do
    column_list << array[0]
  end
  case format
  when "string"
    column_list.join(",") + "\n"
  when "array"
    column_list
  end
end