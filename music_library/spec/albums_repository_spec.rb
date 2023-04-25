require_relative '../lib/albums_repository'


RSpec.describe AlbumsRepository do
  describe AlbumsRepository do
    def reset_albums_table
      seed_sql = File.read('spec/seeds_albums.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
      connection.exec(seed_sql)
    end
  
    before(:each) do 
      reset_albums_table
    end
    
    it "returns number of albums and details of the first album" do
      repo = AlbumsRepository.new

      albums = repo.all
      
      expect(albums.length).to eq 2
      expect(albums.first.id).to eq "1"
      expect(albums.first.title).to eq "Doolittle"
      expect(albums[1].release_year).to eq "1974"
      expect(albums[1].artist_id).to eq "2"
    end

    it "returns the first album 'Doolittle' details" do
          # 2
      # Get the first album 'Doolittle'

      repo = AlbumsRepository.new
      albums = repo.find(1)

      albums.title # => 'Doolittle'
      albums.release_year # => '1989'
      albums.artist_id # => '1'
    end
    
    # xit "returns the second album 'Baltimore' details"
    #   # 3
    #   # get the album Baltimore
    
    #   repo = AlbumsRepository.new
    #   albums = repo.find(9)
    
    #   albums.title # => 'Baltimore'
    #   albums.release_year # => '1978'
    #   albums.artist_id # => '4'
    # end
  end
end