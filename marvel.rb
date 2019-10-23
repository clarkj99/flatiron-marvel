require_relative "./config/environment"
require "pastel"
require "tty-font"
require "tty-reader"
require "tty-prompt"

def marvel_cool_text
  pastel = Pastel.new
  font = TTY::Font.new(:doom)
  puts pastel.red(font.write("MARVEL COMICS"))
end

def marvel_user_prompt
  prompt = TTY::Prompt.new
  answer = prompt.select("Choose your destiny?") do |menu|
    menu.choice "Creators", 1
    menu.choice "Comics", 2
    menu.choice "Characters", -> { "Nice choice Fella!" }
    menu.choice "Exit", -> { "Exit" }
  end
end

marvel_cool_text

answer = ""
until answer == "Exit"
  answer = marvel_user_prompt
  p answer
end
