module ComicMethods
  def comics_menu
    answer = ""
    prompt = TTY::Prompt.new

    #Opens comics menu when comics is chosen from starting menu
    until answer == :back_menu
      print_page_title("Comics")
      puts "\n" + "The total number of Comics in the database: " + Comic.count.to_s
      puts print_comic_with_most_characters
      puts print_comic_with_longest_name
      puts print_comic_with_largest_price

      answer = prompt.select("\n" + "What about the Comics?") do |menu|
        menu.choice "List the Comics!", :comics_list
        menu.choice "Search for Comics by ID", :comics_by_id
        # menu.choice "Search for Comics  by Name", :comics_by_name
        menu.choice "Back", :back_menu
      end
      send(answer)
    end
  end

  def print_comic_with_most_characters
    result = CharacterComic.all.group(:comic_id).count.max_by { |k, v| v }
    comic = Comic.find_by_id(result[0])
    puts "Comic with most characters: " + formatted_comic(comic) + "  -  " + result[1].to_s + " characters\n"
  end

  def print_comic_with_longest_name
    result = Comic.all.max_by { |k, v| k[:title].length }
    puts "Comic with longest name: " + formatted_comic(result) + "\n"
  end

  def print_comic_with_largest_price
    result = Comic.all.max_by { |k, v| k[:price] }
    puts "Comic with largest price: " + formatted_comic(result) + "\n"
  end

  def list_comics_by_chunk(start, chunk_size)
    print_page_title("List the Comics from #{start.to_s} to #{(start + chunk_size - 1).to_s}")

    data = Comic.all.offset(start).limit(chunk_size).order("title").inject("") do |string, comic|
      string = string + formatted_comic(comic) + "\n"
    end

    show_pager(data)
  end

  def comics_list
    answer = ""
    prompt = TTY::Prompt.new

    until answer == :back_menu
      print_page_title("List the Comics By Chunk")

      answer = prompt.select("Choose a chunk of Comics to go through") do |menu|
        menu.choice "List the comics from 0 to 9999", 0
        menu.choice "List the comics from 10,000 to 19,999", 10000
        menu.choice "List the comics from 20,000 to 29,999", 20000
        menu.choice "List the comics from 30,000 to 39,999", 30000
        menu.choice "List the comics from 40,000 to 49,999", 40000
        menu.choice "Back", :back_menu
      end

      if answer == :back_menu
        :back_menu
      else
        list_comics_by_chunk(answer, 10000)
      end
    end
  end

  def comic_characters_list(comic)
    print_page_title("List the Comic's Characters")

    data = comic.characters.order("name").inject("") do |string, character|
      string = string + formatted_character(character) + "\n"
    end

    show_pager(data)
  end

  def comic_creators_list(comic)
    print_page_title("List the Comic's Creators")

    data = comic.creators.inject("") do |string, creator|
      string = string + formatted_creator(creator) + "\n"
    end

    show_pager(data)
  end

  def comics_by_name
    print_page_title("Search for Comics by Name")
  end

  def comic_id_menu(comic)
    answer = ""
    prompt = TTY::Prompt.new

    until answer == :back_menu
      print_page_title("Comic ##{comic["id"]}: #{comic["title"]}")
      puts " Number of creators: " + comic.creators.count.to_s
      puts " Number of characters: " + comic.characters.count.to_s

      answer = prompt.select("What would you like to know about #{comic["title"]}?") do |menu|
        menu.choice "List the creators who worked on #{comic["title"]}", :comic_creators_list
        menu.choice "List the characters that appear in #{comic["title"]}", :comic_characters_list
        menu.choice "Back", :back_menu
      end

      self.send(answer, comic)
    end
  end

  def comics_by_id
    print_page_title("Search for Comics by ID")

    prompt = TTY::Prompt.new
    id = prompt.ask("Provide number in range: 1-84448?") { |id| id.in("1-84448") }
    comic = Comic.find_by_id(id)
    # puts "Looking for Comic(#{id})"
    if comic != nil
      comic_id_menu(comic)
    else
      print_alert("Comic id ##{id} was not found!")
    end
  end
end
