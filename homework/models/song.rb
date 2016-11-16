require('pg')

class Song

attr_accessor :title
attr_reader :id, :track_number, :album_id

  def initialize(params)
    @title = params['title']
    @track_number = params['track_number'].to_i
    @album_id = params["album_id"].to_i
    @id = params['id'].to_i if params['id']

  end

  def save
    sql = "INSERT INTO songs (title, track_number, album_id)
    VALUES
    ('#{@title}', #{@track_number}, #{@album_id}) RETURNING *;"
    id_finder = SqlRunner.run(sql)
    @id = id_finder[0]['id'].to_i
  end

  def delete
    return unless @id
    sql = "DELETE FROM songs WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

 def find_album
  sql = "SELECT * FROM albums WHERE id = #{@album_id};"
  result = SqlRunner.run(sql)
  album = Album.new(result[0])
  return album
 end

  def find_artist
    result = find_album
    return result.artist
  end

  def find_by_track_number
    sql = "SELECT * FROM songs WHERE track_number = #{@track_number};"
    result = SqlRunner.run(sql)
    song = Song.new(result[0])
    return song
  end
  
end
