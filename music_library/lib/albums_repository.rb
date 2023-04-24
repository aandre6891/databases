require_relative 'albums'

class AlbumsRepository
  def all
    repo = 'SELECT id, title, release_year, artist_id FROM albums;'
    result_set = DatabaseConnection.exec_params(repo, [])

    albums = []

    result_set.each do |record|
      album = Albums.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']
      albums << record
    end

    return albums
  end
end