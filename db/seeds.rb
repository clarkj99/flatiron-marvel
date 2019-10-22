# Seed data comes direct from Marvel.
# Construct API calls and loop through JSON
# to get data and populate tables.
# 'rake db:seed' to execute

def api_response(url:, limit: 100, offset:) # Grabs the API url and asks for arguments of limit and offset to grab our data. Limit default to 100.
  # hash = md5(timestamp + private_key + public_key)
  # API request = url + apikey + timestamp + hash
  public_key = CONFIG[:my_key]
  private_key = CONFIG[:secret_key]
  ts = Time.now.to_s

  md5 = Digest::MD5.hexdigest(ts + private_key + public_key)

  request = "#{url}&apikey=#{public_key}&ts=#{ts}&hash=#{md5}&limit=#{limit}&offset=#{offset}"

  RestClient.get(request)
end

# ---- Comics ----
#------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 45632 Comic Records on Marvel

puts "------"
puts "working on comics ..."
puts "------"

Comic.destroy_all
ComicCreator.destroy_all
CharacterComic.destroy_all

comic_url = "http://gateway.marvel.com/v1/public/comics?" # The url which grabs comic's API data.

counter = 0
chunk_size = 100
until counter == 457 #Loops however many times you need according to counter to grab all of our specific API data
  puts counter * chunk_size
  response = api_response(url: comic_url, limit: chunk_size, offset: chunk_size * counter)

  results = JSON.parse(response)["data"]["results"]

  results.each do |comic|
    # p comic["id"]
    Comic.find_or_create_by(id: comic["id"], title: comic["title"], description: comic["description"], issue_number: comic["issueNumber"], page_count: comic["pageCount"], price: comic["prices"][0]["price"])
    if comic["characters"]["available"] > 0
      comic["characters"]["items"].each do |character|
        CharacterComic.find_or_create_by(character_id: character["resourceURI"].split("/").last, comic_id: comic["id"])
      end
    end

    if comic["creators"]["available"] > 0
      comic["creators"]["items"].each do |creator|
        # puts "   " + creator["resourceURI"].split("/").last + "  " + creator["name"]
        ComicCreator.find_or_create_by(comic_id: comic["id"], creator_id: creator["resourceURI"].split("/").last)
      end
    end
  end

  counter += 1
end

#------------------------------------------------------------------------------------------------------------------------------------------------------------------
#1493 Characters on Marvel

puts "------"
puts "working on characters ..."
puts "------"

Character.destroy_all
character_url = "http://gateway.marvel.com/v1/public/characters?" # The url which grabs character's API data.

counter = 0
chunk_size = 100
until counter == 15 #Loops however many times you need according to counter to grab all of our specific API data
  puts counter * chunk_size
  response = api_response(url: character_url, limit: chunk_size, offset: chunk_size * counter)

  results = JSON.parse(response)["data"]["results"]

  results.each do |character|
    # a = character["id"].to_s + " " + character["name"] + " " + character["description"]
    Character.find_or_create_by(id: character["id"], name: character["name"], description: character["description"])
  end

  counter += 1
end

#------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 5212 Creator Records

puts "------"
puts "working on creators ..."
puts "------"

Creator.destroy_all
creator_url = "http://gateway.marvel.com/v1/public/creators?" # The url which grabs creator's API data.

counter = 0
chunk_size = 100
until counter == 53 #Loops however many times you need according to counter to grab all of our API data
  puts counter * chunk_size
  response = api_response(url: creator_url, limit: chunk_size, offset: chunk_size * counter)

  results = JSON.parse(response)["data"]["results"]

  results.each do |creator|
    Creator.find_or_create_by(id: creator["id"], full_name: creator["fullName"])
  end

  counter += 1
end
