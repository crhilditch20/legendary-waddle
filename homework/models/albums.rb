require('pg')
require ('pry-byebug')
require_relative('../db/sql_runner')

class Album

  attr_accessor :title, :genre
  attr_reader :id, :artist_id

  def initialize(params)
    @title = params["title"]
    @genre = params["genre"]
    @id = params["id"].to_i if params["id"]
    @artist_id = params["artist_id"].to_i
  end

  def save
    sql="INSERT INTO albums (title,genre,artist_id)
    VALUES
    ('#{@title}','#{@genre}',#{@artist_id}) RETURNING *;"
    id_finder=SqlRunner.run(sql)
    @id=id_finder[0]['id'].to_i
  end

  def self.all
    sql="SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    return albums.map{|hash| Album.new(hash)}
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id=#{@artist_id};"
    result = SqlRunner.run(sql)
    artist = Artist.new(result[0])
    return artist
  end

  def self.delete_all
    sql="DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def delete
    return unless @id
    sql="DELETE FROM albums WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def update
    sql="UPDATE albums SET
    (title) = ('#{@title}'),(genre)=('#{@genre}') WHERE id=#{@id};"
    SqlRunner.run(sql)
  end

  def find_by_id
    sql = "SELECT * FROM albums WHERE id = #{@id};"
    result = SqlRunner.run(sql)
    return result[0]
  end

  def song_list
    sql = "SELECT * FROM songs WHERE album_id = #{id};"
    results = SqlRunner.run(sql)
    return results.map{|hash| Song.new(hash)}
  end

  def song_count
    result = song_list
    return result.count
  end

  def song_by_track_number(number)
   results = song_list
    for song in results
      if song.track_number ==number
        return song
      end
    end
  end

end