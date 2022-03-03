# Return most long word from a word_list.
def max_length(word_list)
  word_list.map{|word| word.size}.max
end

# Make a table from csv data using make_row() method.
def make_table(csv, encryptor)
  scale = 20
  columns = get_columns("array")
  make_row(columns, scale)
  puts_separation("=", scale, columns.size)
  csv.each do |data|
    make_row([data["service"], encryptor.decrypt_and_verify(data["username"]), encryptor.decrypt_and_verify(data["password"])], scale)
    puts_separation("-", scale, columns.size)
  end
end

# Make a row of a table.
def make_row(word_list, scale)
  number_of_lines = max_length(word_list) / scale + 1
  for i in 0...number_of_lines do
    line = "|"
    for word in word_list do
      word_sliced = word[scale*i...scale*(i+1)].to_s
      line += word_sliced + " "*(scale-word_sliced.size) + "|"
    end
    puts line
  end
end

# Make a Ruled line.
def puts_separation(mark, scale, columns_length)
  puts mark * (scale * columns_length + columns_length + 1)
end

# Get columns as string or array
def get_columns(format)
  column_list = ["service", "username", "password"]
  case format
  when "string"
    column_list.join(",") + "\n"
  when "array"
    column_list
  end
end