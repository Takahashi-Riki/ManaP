class Service
  attr_accessor :name, :username, :password

  @@passwords_csv = nil
  @@encryptor = nil

  def initialize(name, username, password)
    @name = name
    @username = username
    @password = password
  end

  class << self
    def passwords_csv
      @@passwords_csv
    end
  
    def passwords_csv=(csv)
      @@passwords_csv = csv
    end
  
    def encryptor
      @@encryptor
    end
  
    def encryptor=(encryptor)
      @@encryptor = encryptor
    end

    def show_all_passwords
      puts "【Your Passwords】"
      make_table(@@passwords_csv, @@encryptor)
    end

    def delete_from_csv(service_name)
      csv_table = CSV.table("./config/password.csv")
      csv_table.by_row!
      csv_table.delete_if{|row| row[:service] == service_name}
      csv_table.each { |row| p row[:service] }
      File.write("./config/password.csv", csv_table)
    end
  end

  def register_to_csv
    CSV.open("./config/password.csv", "a", encoding: "Shift_JIS:UTF-8") do |csv|
      information_to_register = []
      information_to_register << self.name
      information_to_register << self.username
      information_to_register << self.password
      csv << information_to_register
    end
  end
end