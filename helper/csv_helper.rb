def get_max_length(word_list)
  max_word = ""
  for i in 0..word_list.size-1 do
    max_word = word_list[i] if word_list[i].size >= max_word.size
  end
  return max_word.size
end

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

def puts_line(mark, scale, columns_length)
  puts mark * (scale * columns_length + columns_length + 1)
end

def make_table(csv, encryptor)
  scale = 20
  columns = ["service", "username", "password"]
  make_row(columns, scale)
  puts_line("=", scale, columns.size)
  csv.each do |data|
    make_row([data["service"], encryptor.decrypt_and_verify(data["username"]), encryptor.decrypt_and_verify(data["password"])], scale)
    puts_line("-", scale, columns.size)
  end
end