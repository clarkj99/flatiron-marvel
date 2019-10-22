# This ruby file was created to figure out
# how to do the API call to Marvel

require_relative "./config/environment"

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

#------------------------------------------------------------------------------------------------------------------------------------------------------------------

puts "------"
puts "working on comics ..."
puts "------"

comic_url = "http://gateway.marvel.com/v1/public/comics?" # The url which grabs comic's API data.

counter = 0
chunk_size = 5
until counter == 3 #Loops however many times you need according to counter to grab all of our specific API data
  puts counter * chunk_size
  response = api_response(url: comic_url, limit: chunk_size, offset: chunk_size * counter)

  results = JSON.parse(response)["data"]["results"]

  results.each do |comic|
    a = comic["id"].to_s + " " + comic["title"] + " " + comic["issueNumber"].to_s + " " + comic["pageCount"].to_s + " " + comic["prices"][0]["price"].to_s + " chars: " + comic["characters"]["available"].to_s

    puts a #Comic.create
    if comic["characters"]["available"] > 0
      #   puts "--- I'm creating #{comic["characters"]["available"]} character-comic entries ---"
      #   characters = comic["characters"]["items"]
      comic["characters"]["items"].each do |character|
        puts "   " + character["resourceURI"].split("/").last + "  " + character["name"] #CharacterComic.create
      end
    end

    if comic["creators"]["available"] > 0
      puts "*** I'm creating #{comic["creators"]["available"]} comic-creator entries ***"
      comic["creators"]["items"].each do |creator|
        puts "   " + creator["resourceURI"].split("/").last + "  " + creator["name"]  #ComicCreator.create
      end
    end
  end

  counter += 1
end

#------------------------------------------------------------------------------------------------------------------------------------------------------------------

puts "------"
puts "working on characters ..."
puts "------"

character_url = "http://gateway.marvel.com/v1/public/characters?" # The url which grabs character's API data.

counter = 0
chunk_size = 5
until counter == 3 #Loops however many times you need according to counter to grab all of our specific API data
  puts counter * chunk_size
  response = api_response(url: character_url, limit: chunk_size, offset: chunk_size * counter)

  results = JSON.parse(response)["data"]["results"]

  results.each do |character|
    a = character["id"].to_s + " " + character["name"] + " " + character["description"]

    puts a # Character.create
  end

  counter += 1
end

#------------------------------------------------------------------------------------------------------------------------------------------------------------------

puts "------"
puts "working on creators ..."
puts "------"

creator_url = "http://gateway.marvel.com/v1/public/creators?" # The url which grabs creator's API data.

counter = 0
chunk_size = 5
until counter == 3 #Loops however many times you need according to counter to grab all of our API data
  puts counter * chunk_size
  response = api_response(url: creator_url, limit: chunk_size, offset: chunk_size * counter)

  results = JSON.parse(response)["data"]["results"]

  results.each do |creator|
    a = creator["id"].to_s + " " + creator["firstName"] + " " + creator["lastName"]

    puts a # Creator.create
  end

  counter += 1
end
