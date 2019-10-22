# This ruby file was created to figure out
# how to do the API call to Marvel

require_relative "./config/environment"

puts "working..."

comic_url = "http://gateway.marvel.com/v1/public/comics?limit=5"
public_key = CONFIG[:my_key]
private_key = CONFIG[:secret_key]
ts = Time.now.to_s

# hash = md5(timestamp + private_key + public_key)
# API request = url + apikey + timestamp + hash

md5 = Digest::MD5.hexdigest(ts + private_key + public_key)
request = comic_url + "&apikey=" + public_key + "&ts=" + ts + "&hash=" + md5

response = RestClient.get(request)

results = JSON.parse(response)["data"]["results"]

results.each do |comic|
  a = comic["id"].to_s + " " + comic["title"] + " " + comic["issueNumber"].to_s + " " + comic["pageCount"].to_s + " " + comic["prices"][0]["price"].to_s
  puts a
end
