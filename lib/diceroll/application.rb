module Diceroll
  module Application
    extend self

    def run(console_type)
      case console_type
      when "pry"
        Diceroll::GameEngine.new PryConsole.new
      when "basic"
        Diceroll::GameEngine.new BasicConsole.new
      else
        raise UnknownConsoleType
      end
    end
  end
end
