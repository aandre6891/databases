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

    describe "#print_artists" do
      it "returns the list of artists" do
        fake_app = double :Application, print_artists: '1. Pixies (Rock) 2. ABBA (Pop)'
        expect(fake_app.print_artists).to eq ('1. Pixies (Rock) 2. ABBA (Pop)')
      end
    end
    describe "#print_albums" do
      it "returns the list of artists" do
        fake_app = double :Application, print_albums: '1. Doolittle - 1989 - Artist n. 1 2. Waterloo - 1974 - Artist n. 2'
        expect(fake_app.print_albums).to eq ('1. Doolittle - 1989 - Artist n. 1 2. Waterloo - 1974 - Artist n. 2')
      end
    end
  end
end
