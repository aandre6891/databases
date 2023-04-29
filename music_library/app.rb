
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
    @io.puts "Welcome to the music library manager!"
    @io.puts ""
    @io.puts "What would you like to do?" 
    @io.puts "1 - List all albums"
    @io.puts "2 - List all artists"
    @io.puts ""
    @io.print "Enter your choice: "
    selection = @io.gets.to_i
    @io.puts ""

    if selection == 1
      print_albums
    elsif selection == 2
      print_artists
    end
  end

  def print_artists
    puts "Here is the list of artists:"
    @artist_repository.all.each do |artist|
      puts "* #{artist.id} - #{artist.name} (#{artist.genre})"
    end   
  end

  def print_albums    
    puts "Here is the list of albums:"
    @album_repository.all.each do |album|
      p "* #{album.id} - #{album.title}"
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