module Constant
  module General
    SEPARATION_LINE = "=" * 64
  end
  

  module Greeting
    LOGO = <<~LOGO

      ##    ##                            #### 
      ###  ##                             ## ##
      ###  ##    ###     ####     ###     ##  #
      # # # #    #  #    ##  #    #  #    ## ##
      #  ## #       #    #   #       #    #### 
      #  #  #    ####    #   #    ####    ##   
      #     #   ##  #    #   #   ##  #    ##   
      ##   ###   #####   ## ###   #####   ##   

    LOGO

    FINISH_MESSAGE = "Thank you for using. Goodbye!"
  end
  
  module Usage
    include General

    COMMAND_LIST = <<~TEXT
      【Command List】
      Finish using                : exit
      See how to use              : manual
      Reset all data              : reset [your key]
      Show your passwords         : show
      Register a new password     : register [service name] [username] [password]
      Delete a existing password  : delete  [service name]
      (eg. register FGmail hello@example.com a23s34d)
    TEXT

    ACCEPT_COMMAND_MESSAGE = <<~GREETING_AND_USAGE
      #{General::SEPARATION_LINE}
      Please type commands.
      #{COMMAND_LIST}
    GREETING_AND_USAGE

    MANUAL_MESSAGE = <<~MANUAL
      #{General::SEPARATION_LINE}
      Q. What is ManaP?
      This application is made to manage your passwords with one password.

      Q. What is the "key"?
      You can manage all of your passwords with one password. The password is called "key" in this service.

      Q. How to use?
      1. First of all, register your key. Maybe you already have done.
      2. You can manage your passwords with commands. When to type commands English can only be used.
      #{COMMAND_LIST}
    MANUAL
  end

  module Authentication
    include General

    FIRST_TIME_MESSAGE = <<~MESSAGE
      #{General::SEPARATION_LINE}
      Hello, this is the first time I've met you.
      Let's set your key. Key is needed to manage your passwords.
    MESSAGE

    ACCEPT_KEY_MESSAGE = "Please type your key."
  end

  module Error
    PASSWORD_LENGTH_NOT_SUITABLE_MESSAGE = "ERROR: Key must be at least 6 characters and less than 33 characters."

    PASSWORD_NOT_ACCEPTED_MESSAGE        = "ERROR: Please type your correct key."

    COMMAND_NOT_ACCEPTED_MESSAGE         = "ERROR: Please type a suitable command."

    INVALID_ARGS_TO_COMMAND_MESSAGE      = "ERROR: Please type the required quantity of commands"
  end
  
  module Success
    OK_MESSAGE = "NOTICE: OK."

    PASSWORD_SUCCESSFULLY_RESETED_MESSAGE = "NOTICE: Please restart."
  end
end