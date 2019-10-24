module CreatorMethods
  def creators_menu
    answer = ""
    prompt = TTY::Prompt.new

    until answer == :back_menu
      print_page_title("Creators")
      puts "\n" + "The total number of Creators in the database: " + Creator.count.to_s
      answer = prompt.select("\n" + "What about the Creators?") do |menu|
        menu.choice "List the Creators!", :creators_list
        menu.choice "Search for Creators by ID", :creators_by_id
        # menu.choice "Search for Creators  by Name", :creators_by_name
        menu.choice "Back", :back_menu
      end
      send(answer)
    end
  end

  def creators_list
    print_page_title("List the Creators")

    data = Creator.all.inject("") do |string, creator|
      string = string + creator["id"].to_s + "  " + creator["full_name"] + "\n"
    end

    show_pager(data)
  end

  def creator_characters_list(creator)
    print_page_title("List the Creator's Characters")

    data = creator.characters.order("name").inject("") do |string, character|
      string = string + character["id"].to_s + "  " + character["name"] + ": " + character["description"] + "\n"
    end

    show_pager(data)
  end

  def creator_comics_list(creator)
    print_page_title("List the Creator's Comics")

    data = creator.comics.order("title").inject("") do |string, comic|
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
    creator = Creator.find_by_id(id)
    # puts "Looking for Creator(#{id})"
    if creator != nil
      answer = ""
      prompt = TTY::Prompt.new

      until answer == :back_menu
        puts " Creator ##{creator["id"]}: #{creator["full_name"]}"
        puts " Number of comics: " + creator.comics.count.to_s
        puts " Number of characters: " + Creator.find(id).characters.count.to_s

        answer = prompt.select("What would you like to know about #{creator["full_name"]}?") do |menu|
          menu.choice "List the comics by #{creator["full_name"]}", :creator_comics_list
          menu.choice "List the characters created by #{creator["full_name"]}", :creator_characters_list
          menu.choice "Back", :back_menu
        end

        self.send(answer, creator)
      end
    else
      puts "Creator id # #{id} was not found!!!!"
    end
  end
end
