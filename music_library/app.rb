# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/artists_repository'
require_relative 'lib/albums_repository'
# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

class Application
  def print_artists
    artists_repository = ArtistsRepository.new
    
    puts "List of artists:"
    list_of_artists = artists_repository.all.each do |artist|
      puts "#{artist.id}. #{artist.name} (#{artist.genre})"
    end   
  end

  def print_albums
    albums_repository = AlbumsRepository.new
    
    puts "List of albums:"
    albums_repository.all.each do |album|
      p "#{album.id}. #{album.title} - #{album.release_year} - Artist n. #{album.artist_id}"
    end
  end

  def run
    puts "Please, select:" 
    puts "1. Print the artists"
    puts "2. Print the albums."
    selection = gets.chomp
    if selection == '1'
      print_artists
    elsif selection == '2'
      print_albums
    end
  end
end

Application.new.run



# puts "-" * 30

