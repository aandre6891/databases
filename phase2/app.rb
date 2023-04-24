# file: app.rb

require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

artists_repository = ArtistsRepository.new

p artists_repository.all