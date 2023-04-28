
require_relative 'lib/database_connection'
require_relative 'lib/artists_repository'
require_relative 'lib/albums_repository'
class Application
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts "Please, select:" 
    @io.puts "1. Print the artists"
    @io.puts "2. Print the albums."
    selection = @io.gets.chomp
    if selection == '1'
      print_artists
    elsif selection == '2'
      print_albums
    end
  end

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
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
  if __FILE__ == $0
    app = Application.new(
      'music_library',
      Kernel,
      AlbumsRepository.new,
      ArtistsRepository.new
    )
    app.run
  end