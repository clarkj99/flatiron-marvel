require "pastel"
require "tty-font"
require "tty-reader"
require "tty-prompt"

class CommandLineInterface
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

  def creators_menu
    print_page_title("Creators")
    puts "The total number of Creators in the database: " + Creator.count.to_s

    answer = ""
    prompt = TTY::Prompt.new

    until answer == :back_menu
      answer = prompt.select("Choose your destiny?") do |menu|
        menu.choice "List the Creators!", :creators_list
        menu.choice "Search for Creators  by ID", :creators_by_id
        # menu.choice "Search for Creators  by Name", :creators_by_name
        menu.choice "Back", :back_menu
      end
      send(answer)
    end
  end

  ##### BEGIN CREATORS STUFFFFFFF

  def creators_list
    print_page_title("List the Creators")

    data = Creator.all.inject("") do |string, creator|
      string = string + creator["id"].to_s + "  " + creator["full_name"] + "\n"
    end

    show_pager(data)
  end

  def creator_characters_list(creator)
    print_page_title("List the Creator's Characters")

    data = creator.characters.inject("") do |string, character|
      string = string + character["id"].to_s + "  " + character["name"] + ": " + character["description"] + "\n"
    end

    show_pager(data)
  end

  def creator_comics_list(creator)
    print_page_title("List the Creator's Comics")

    data = creator.comics.inject("") do |string, comic|
      string = string + comic["id"].to_s + "  " + comic["title"] + " " + comic["issue_number"].to_s + " " + comic["page_count"].to_s + " pages" + " $" + comic["price"].to_s + "\n"
    end

    show_pager(data)
  end

  def creators_by_name
    print_page_title("Find a Creator by Name")
  end

  def creators_by_id
    print_page_title("Find a Creator by ID")

    prompt = TTY::Prompt.new
    id = prompt.ask("Provide number in range: 1-13924?") { |id| id.in("1-13924") }
    creator = Creator.find(id)
    # puts "Looking for Creator(#{id})"
    answer = ""
    prompt = TTY::Prompt.new

    until answer == :back_menu
      puts " Creator ##{creator["id"]}: #{creator["full_name"]}"
      puts " Number of comics: " + creator.comics.count.to_s
      puts " Number of characters: " + Creator.find(id).characters.count.to_s

      answer = prompt.select("Choose your destiny?") do |menu|
        menu.choice "List the comics by #{creator["full_name"]}", :creator_comics_list
        menu.choice "List the characters by #{creator["full_name"]}", :creator_characters_list
        menu.choice "Back", :back_menu
      end

      self.send(answer, creator)
    end
  end

  ###### END CREATORS STUFFFFF

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
