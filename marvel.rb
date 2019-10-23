require_relative "./config/environment"
require "pastel"
require "tty-font"
require "tty-reader"
require "tty-prompt"

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
  pager = TTY::Pager::SystemPager.new
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

def creators_menu
  print_page_title("Creators")
  answer = ""
  prompt = TTY::Prompt.new

  puts "The total number of Creators in the database: " + Creator.count.to_s

  until answer == :back_menu
    answer = prompt.select("Choose your destiny?") do |menu|
      menu.choice "List the Creators!", :creators_list
      menu.choice "Search for Creators  by ID", :creators_by_id
      menu.choice "Search for Creators  by Name", :creators_by_name
      menu.choice "Back", :back_menu
    end
    send(answer)
  end
end

def creators_list
  puts "List the Creators"

  data = Creator.all.inject("") do |string, creator|
    string = string + creator["id"].to_s + "  " + creator["full_name"] + "\n"
  end

  show_pager(data)
end

def creators_by_name
  puts "Find a Creator by Name"
end

def creators_by_id
  puts "Find a Creator by ID"

  prompt = TTY::Prompt.new
  id = prompt.ask("Provide number in range: 1-13924?") { |id| id.in("1-13924") }
  puts "Looking for Creator(#{id})"
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

def back_menu
  puts "Stay tuned, True Believers!"
end

marvel_cool_text("MARVEL COMICS")

answer = ""
until answer == :exit_menu
  answer = marvel_user_prompt
  send(answer)
end
