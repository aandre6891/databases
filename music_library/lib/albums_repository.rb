require_relative 'albums'

class AlbumsRepository
  def all
    sql = 'SELECT id, title, release_year, artist_id FROM albums ORDER BY id ASC;'
    result_set = DatabaseConnection.exec_params(sql, [])

    albums = []

    result_set.each do |record|
      album = Albums.new
      album.id = record["id"]
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']
      albums << album
      
    end
    return albums
  end

  def find(id)
    sql = 'SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
    sql_params = [id]
    sql_selection = DatabaseConnection.exec_params(sql, sql_params)

    record = sql_selection[0]

    album = Albums.new
    album.id = record['id']
    album.title = record['title']
    album.release_year = record['release_year']
    album.artist_id = record['artist_id']

    return album
  end  
end