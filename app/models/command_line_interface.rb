require "pastel"
require "tty-font"
require "tty-reader"
require "tty-prompt"
require_relative "../modules/creator_methods"

class CommandLineInterface
  include CreatorMethods

  def marvel_cool_text(string)
    pastel = Pastel.new
    font = TTY::Font.new(:doom)
    puts pastel.red(font.write(string))
  end

  def marvel_user_prompt
    prompt = TTY::Prompt.new
    answer = prompt.select("Choose your destiny?") do |menu|
      menu.choice "Creators", :creators_menu
      menu.choice "Comics", :comics_menu
      menu.choice "Characters", :characters_menu
      menu.choice "Exit", :exit_menu
    end
  end

  def show_help
    puts " This is the help"
  end

  def show_pager(data)
    pager = TTY::Pager::BasicPager.new
    pager.page(data)
  end

  def print_page_title(string)
    start_char = "="
    spacer_char = "-"
    border_length = 30
    border = start_char + Array.new(border_length, spacer_char).join + start_char
    num_spaces = (border_length - string.length) / 2
    puts border
    puts spacer_char + Array.new(num_spaces, " ").join + string + Array.new(num_spaces, " ").join + spacer_char
    puts border
  end

  def characters_menu
    puts "Characters"
  end

  def comics_menu
    puts "Comics"
  end

  def exit_menu
    marvel_cool_text("Excelsior!")
  end

  def back_menu(creator = nil)
    puts "Stay tuned, True Believers!"
  end

  def main_loop
    marvel_cool_text("MARVEL COMICS")

    answer = ""
    until answer == :exit_menu
      answer = marvel_user_prompt
      send(answer)
    end
  end
end
