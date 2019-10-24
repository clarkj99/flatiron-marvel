module CharacterMethods
  def characters_menu
    answer = ""
    prompt = TTY::Prompt.new

    until answer == :back_menu
      print_page_title("Characters")
      puts "The total number of Characters in the database: " + Character.count.to_s
      print_character_with_most_comics

      answer = prompt.select("Choose your destiny?") do |menu|
        menu.choice "List the Characters!", :characters_list
        menu.choice "Search for Characters  by name", :characters_by_name
        # menu.choice "Search for Creators  by Name", :creators_by_name
        menu.choice "Back", :back_menu
      end
      send(answer)
    end
  end

  def print_character_with_most_comics
    result = CharacterComic.all.group(:character_id).count.max_by { |k, v| v }
    character = Character.find_by_id(result[0])
    puts "Character with most titles: " + formatted_character(character) + "  -  " + result[1].to_s + " titles\n"
  end

  def characters_list
    print_page_title("List the Characters")

    data = Character.all.inject("") do |string, character|
      string = string + formatted_character(character) + "\n"
    end

    show_pager(data)
  end

  def character_creators_list(character)
    print_page_title("List the Character's Creators")

    data = character.creators.inject("") do |string, creator|
      string = string + formatted_creator(creator) + "\n"
    end

    show_pager(data)
  end

  def character_comics_list(character)
    print_page_title("List the Character's Comics")

    data = character.comics.inject("") do |string, comic|
      string = string + formatted_comic(comic) + "\n"
    end

    show_pager(data)
  end

  def characters_by_name
    print_page_title("Find a Character by name")

    prompt = TTY::Prompt.new
    name = prompt.ask("Provide a name to search for: ") do |character|
      character.required true
    end
    character = Character.find_by(name: name)

    if character != nil
      answer = ""
      prompt = TTY::Prompt.new

      until answer == :back_menu
        puts " Character: #{character["name"]}"
        puts " Number of comics: " + character.comics.count.to_s
        puts " Number of creators: " + character.creators.count.to_s

        answer = prompt.select("Choose your destiny?") do |menu|
          menu.choice "List the comics including #{character["name"]}", :character_comics_list
          menu.choice "List the characters including #{character["name"]}", :character_creators_list
          menu.choice "Back", :back_menu
        end

        self.send(answer, character)
      end
    else
      puts "Character name: #{name} was not found!!!!"
    end
  end
end
