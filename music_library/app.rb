# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/artists_repository'
require_relative 'lib/albums_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

artists_repository = ArtistsRepository.new

puts "List of artists:"
artists_repository.all.each do |artist|
  p "#{artist.id}. #{artist.name} (#{artist.genre})"
end

puts "-" * 30

albums_repository = AlbumsRepository.new

puts "List of albums:"
albums_repository.all.each do |album|
  p "#{album.id}. #{album.title} - #{album.release_year} - Artist n. #{album.artist_id}"
end