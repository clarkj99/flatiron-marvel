require_relative "../config/environment.rb"

# tp Character.all
pager = TTY::Pager::BasicPager.new
pager.page(tp.to_s Character.all)
# tp.methods
