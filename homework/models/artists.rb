require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(params)
    @name=params["name"]
    @id=params["id"].to_i if params["id"]
  end
  
  def save
    sql="INSERT INTO artists (name)
    VALUES
    ('#{@name}') RETURNING *;"
    id_finder=SqlRunner.run(sql)
    @id=id_finder[0]['id'].to_i
  end

  def self.all
    sql="SELECT * FROM artists;"
    artists = SqlRunner.run(sql)
    return artists.map{|hash| Artist.new(hash)}
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id=#{@id};"
    result = SqlRunner.run(sql)
    album_list = result.map{|hash| Album.new(hash)}
    return album_list
  end

  def self.delete_all
    sql="DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def delete
    return unless @id
    sql="DELETE FROM artists WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def update
    sql="UPDATE artists SET
    (name) = ('#{@name}') WHERE id=#{@id};"
    SqlRunner.run(sql)
  end

  def find_by_id
    sql = "SELECT * FROM artists WHERE id = #{@id}"
    result = SqlRunner.run(sql)
    return result[0]
  end

end