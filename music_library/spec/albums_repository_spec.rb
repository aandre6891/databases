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
    
    it "" do
      repo = AlbumsRepository.new

      albums = repo.all
      
      expect(albums.length).to eq 2
      expect(albums.first.id).to eq '1'
      expect(albums.first.title).to eq 'Doolittle'
      expect(albums[1].release_year).to eq '1974'
      expect(albums[1].artist_id).to eq '2'
    end
  end
end