require 'uri'
require 'net/http'

puts "Cleaning database..."
Bookmark.destroy_all
Movie.destroy_all
List.destroy_all
puts "Database cleaned"

url = URI("https://tmdb.lewagon.com/movie/top_rated")

1.times do |i|
  puts "Importing movies from page #{i + 1}"
  movies = JSON.parse(Net::HTTP.get(URI("#{url}?page=#{i + 1}")))["results"]

  movies.each do |movie|
    puts "Creating #{movie["title"]}"
    base_poster_url = "https://image.tmdb.org/t/p/original"
    Movie.create(
      title: movie["title"],
      overview: movie["overview"],
      poster_url: "#{base_poster_url}#{movie["backdrop_path"]}",
      rating: movie["vote_average"]
    )
  end
end

puts "Movies created"


  # http = Net::HTTP.new(url.host, url.port)
  # http.use_ssl = true

  # request = Net::HTTP::Get.new(url)
  # request["accept"] = 'application/json'

  # response = http.request(request)
  # puts response.read_body

  # puts "Finished!"
