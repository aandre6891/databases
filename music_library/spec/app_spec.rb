require_relative "../app"

RSpec.describe Application do
  describe Application do
    def reset_artists_table
      seed_sql = File.read('spec/seeds_artists.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
      connection.exec(seed_sql)
    end

    before(:each) do 
      reset_artists_table
    end

    describe "#run" do
      it "returns the things of the terminal" do
        io = double :io
        expect(io).to receive(:puts).with("Welcome to the music library manager!").ordered
        expect(io).to receive(:puts).with("").ordered
        expect(io).to receive(:puts).with("What would you like to do?").ordered
        expect(io).to receive(:puts).with("1 - List all albums").ordered
        expect(io).to receive(:puts).with("2 - List all artists").ordered
        expect(io).to receive(:puts).with("").ordered
        expect(io).to receive(:print).with("Enter your choice: ").ordered
        expect(io).to receive(:gets).and_return(1).ordered
        expect(io).to receive(:puts).with("").ordered
        album_repository = AlbumsRepository.new
        artist_repository = ArtistsRepository.new
        application = Application.new('music_library_test', io, album_repository, artist_repository)
        application.run
      end


    end
  end
end
