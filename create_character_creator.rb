require_relative "./config/environment"

Character.all.each do |character|
  character.comics.each do |comic|
    comic.comic_creators.each do |comic_creator|
      #   puts "ci=" + comic_creator["creator_id"].to_s + " c=" + character["id"].to_s
      CharacterCreator.find_or_create_by(character_id: character["id"], creator_id: comic_creator["creator_id"])
    end
  end
end
# Character.find(1009146).comics[0].comic_creators[0]["creator_id"]
