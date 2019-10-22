# Seed data comes direct from Marvel.
# Construct API calls and loop through JSON
# to get data and populate tables.
# 'rake db:seed' to execute

comic_url = "http://gateway.marvel.com/v1/public/comics?limit=100"

public_key = CONFIG[:my_key]
private_key = CONFIG[:secret_key]
ts = Time.now.to_s

# hash = md5(timestamp + private_key + public_key)
# API request = url + apikey + timestamp + hash

md5 = Digest::MD5.hexdigest(ts + private_key + public_key)

# ---- Comics ----
puts "Destroying Comics"
Comic.destroy_all

request = comic_url + "&apikey=" + public_key + "&ts=" + ts + "&hash=" + md5

puts "Creating new Comics"
response = RestClient.get(request)
json_response = JSON.parse(response)

json_response["data"]["results"].each do |comic|
  Comic.create(id: comic["id"], title: comic["title"], issue_number: comic["issueNumber"], page_count: comic["pageCount"], price: comic["prices"][0]["price"])
end
puts json_response["status"] + ", Count: " + json_response["data"]["count"].to_s + ", Total: " + json_response["data"]["total"].to_s
puts "--------------------------------------"
