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

puts "working..."

comic_url = "http://gateway.marvel.com/v1/public/comics?" # The url which grabs comic's API data.

counter = 0
chunk_size = 100
until counter == 3 #Loops however many times you need according to counter to grab all of our API data
  puts counter * chunk_size
  response = api_response(url: comic_url, limit: chunk_size, offset: chunk_size * counter)

  results = JSON.parse(response)["data"]["results"]

  results.each do |comic|
    a = comic["id"].to_s + " " + comic["title"] + " " + comic["issueNumber"].to_s + " " + comic["pageCount"].to_s + " " + comic["prices"][0]["price"].to_s
    # puts a
  end
  counter += 1
end
