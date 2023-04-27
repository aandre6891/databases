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

      repo = AlbumsRepository.new
      albums = repo.find(1)

      expect(albums.title).to eq ("Doolittle")
      expect(albums.release_year).to eq ('1989')
      expect(albums.artist_id).to eq ('1')
    end
    
    it "returns the second album 'Waterloo' details" do
    
      repo = AlbumsRepository.new
      albums = repo.find(2)

      expect(albums.title).to eq ("Waterloo")
      expect(albums.release_year).to eq ('1974')
      expect(albums.artist_id).to eq ('2')
    end

    it "inserts the new album Trompe le Monde" do
      
      repo = AlbumsRepository.new
      new_album = Albums.new
      new_album.title = 'Trompe le Monde'
      new_album.release_year = 1991
      new_album.artist_id = 1

      repo.create(new_album)

      all_albums = repo.all
      last_album = all_albums.last

      expect(last_album.title).to eq 'Trompe le Monde'
      expect(last_album.release_year).to eq '1991'
      expect(last_album.artist_id).to eq '1'
    end

    it "deletes Doolittle from the albums" do
      repo = AlbumsRepository.new

      repo.delete(1)

      all_albums = repo.all

      expect(all_albums.length).to eq 1
      expect(all_albums.first.id).to eq '2'
      expect(all_albums.first.title).to eq 'Waterloo'
    end

    it "deletes all the albums" do
      repo = AlbumsRepository.new

      repo.delete(1)
      repo.delete(2)

      all_albums = repo.all

      expect(all_albums.length).to eq 0
    end

    it "updates the album name and release year" do
      repo = AlbumsRepository.new

      album = repo.find(1)
      album.title = 'Trompe le Monde'
      album.release_year = '1991'

      repo.update(album)

      updated_album = repo.find(1)

      expect(updated_album.title).to eq 'Trompe le Monde'
      expect(updated_album.release_year).to eq '1991'
      expect(updated_album.artist_id).to eq '1'
    end
  end
end