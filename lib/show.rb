require_relative "../config/environment"

require "tty-pager"
require "tty-table"

def show_comics_pager
  pager = TTY::Pager::BasicPager.new

  data = Comic.limit(100).reduce("") do |s, comic|
    s = s + comic["title"] + "\n"
  end

  pager.page(data)
end

def show_comics_table
  data = Comic.limit(10).map do |comic|
    [comic["id"], comic["title"][0..20] + "...", comic["description"][0..20] + "..."]
  end

  table = TTY::Table.new ["Id", "Title", "Description"], data
  puts table.render(:ascii, padding: [0, 2], resize: true)
end

def goodbye
  puts "Bye!"
end

def menu_selection
  choices = [
    { name: "Show Comics With Pager", value: :show_comics_pager },
    { name: "Show Comics With Table", value: :show_comics_table },
    { name: "quit", value: :goodbye },
  ]

  prompt = TTY::Prompt.new
  prompt.enum_select("Choose wisely!", choices)
end

def main_loop
  selection = ""
  until selection == :goodbye
    selection = menu_selection
    self.send(selection)
  end
end

main_loop
