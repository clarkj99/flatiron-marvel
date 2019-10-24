require "pastel"
require "tty-font"
require "tty-reader"
require "tty-prompt"
require_relative "../modules/creator_methods"
require_relative "../modules/comic_methods"
require_relative "../modules/character_methods"

class CommandLineInterface
  include CreatorMethods
  include ComicMethods
  include CharacterMethods

  def marvel_cool_text(string)
    pastel = Pastel.new
    font = TTY::Font.new(:doom)
    puts pastel.red(font.write(string))
  end

  def marvel_user_prompt
    prompt = TTY::Prompt.new
    answer = prompt.select("Which would you like to know more about?") do |menu|
      menu.choice "Creators", :creators_menu
      menu.choice "Comics", :comics_menu
      menu.choice "Characters", :characters_menu
      menu.choice "Exit program", :exit_menu
    end
  end

  def show_help
    print_page_title(" This is the help")
  end

  def show_pager(data)
    pager = TTY::Pager::BasicPager.new
    pager.page(data)
  end

  def print_page_title(string)
    pastel = Pastel.new
    start_char = "="
    spacer_char = "-"
    border_length = string.length + 4
    border = start_char + Array.new(border_length, spacer_char).join + start_char
    puts pastel.bold(border)
    puts pastel.bold(spacer_char + "  " + string.upcase + "  " + spacer_char)
    puts pastel.bold(border)
  end

  def print_alert(string)
    pastel = Pastel.new
    start_char = "="
    spacer_char = "!"
    border_length = string.length + 4
    border = start_char + Array.new(border_length, spacer_char).join + start_char
    # puts border
    puts pastel.on_yellow.bold(spacer_char + "  " + string + "  " + spacer_char)
    # puts border
  end

  def formatted_creator(creator)
    creator["id"].to_s + "  " + creator["full_name"]
  end

  def formatted_comic(comic)
    comic["id"].to_s + "  Title: " + comic["title"] + " / Issue #: " + comic["issue_number"].to_s + " / " + comic["page_count"].to_s + " pages" + " / Costs: $" + comic["price"].to_s
  end

  def formatted_character(character)
    character["id"].to_s + "  " + character["name"] + ": " + character["description"]
  end

  def exit_menu
    marvel_cool_text("Excelsior!")
  end

  def back_menu(creator = nil)
    puts Pastel.new.red("--> Stay tuned, True Believers! <--")
  end

  def main_loop
    marvel_cool_text("MARVEL")
    marvel_cool_text("COMICS")

    answer = ""
    until answer == :exit_menu
      answer = marvel_user_prompt
      send(answer)
    end
  end
end
