require "artists_repository"

RSpec.describe ArtistsRepository do
  describe ArtistsRepository do
    def reset_artists_table
      seed_sql = File.read('spec/seeds_artists.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
      connection.exec(seed_sql)
    end

    before(:each) do 
      reset_artists_table
    end

    it "" do
      repo = ArtistsRepository.new

      artists = repo.all

      expect(artists.length).to eq 2 # =>  2
      expect(artists[0].id).to eq 1 # =>  1
      expect(artists.first.name).to eq "Pixies" # =>  'Pixies'
      expect(artists[0].genre).to eq "Rock" # =>  'Rock'
    end
  end
end