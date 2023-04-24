# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/artists_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

artists_repository = ArtistsRepository.new

artists_repository.all.each do |artist|
  p "#{artist.id} - #{artist.name} - #{artist.genre}"
end