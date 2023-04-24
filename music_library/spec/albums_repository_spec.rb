require_relative 'albums_repository'

RSpect.describe AlbumsRepository do
  it "" do
    def reset_artists_table
      seed_sql = File.read('spec/seeds_albums.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'musicl_library_test' })
      connection.exec(seed_sql)
    end

      before(:each) do 
        reset_albums_table
      end

      repo = AlbumsRepository.new

      albums = repo.all
      
      albums.length # =>  2
      albums[0].id # =>  1
      albums.first.title # =>  'Doolittle'
      albums[1].release_year # =>  '1974'
      albums[1].artist_id # =>  '2'
  end
end