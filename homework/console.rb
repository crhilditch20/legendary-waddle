require ('pry-byebug')
require_relative('models/albums')
require_relative('models/artists')
require_relative('models/song')


artist1 = Artist.new({'name'=>'David Bowie'})
artist1.save()
artist2 = Artist.new({'name'=>'Lucius'})
artist2.save()
artist3 = Artist.new({'name'=>'Paul Simon'})
artist3.save()

album1 = Album.new({'title'=>'Heroes','genre'=>'rock','artist_id'=>artist1.id})
album1.save() 
album2 = Album.new({'title'=>'Black Star','genre'=>'rock','artist_id'=>artist1.id})
album2.save()
album3 = Album.new({'title'=>'Led Zeppelin 2','genre'=>'rock','artist_id'=>artist2.id})
album3.save()
album4 = Album.new({'title' => 'Graceland', 'genre' => 'world', 'artist_id' => artist3.id})
album4.save()
album5 = Album.new({'title' => 'Good Grief', 'genre' => 'alternative', 'artist_id' => artist2.id})
album5.save()

song1 = Song.new({'title' => 'Madness', 'track_number' => 1, 'album_id' => album5.id})
song2 = Song.new({'title' => 'Something About You', 'track_number' => 2, 'album_id' => album5.id})
song3 = Song.new({'title' => 'What We Have', 'track_number' => 3, 'album_id' => album5.id})
song4 = Song.new({'title' => 'My Heart Got Caught On Your Sleeve', 'track_number' => 4, 'album_id' => album5.id})
song5 = Song.new({'title' => 'Almost Makes Me Wish For Rain', 'track_number' => 5, 'album_id' => album5.id})
song6 = Song.new({'title' => 'Gone Insane', 'track_number' => 6, 'album_id' => album5.id})
song7 = Song.new({'title' => 'Truce', 'track_number' => 7, 'album_id' => album5.id})

song1.save()
song2.save()
song3.save()
song4.save()
song5.save()
song6.save()
song7.save()

song1.find_album()

album5.song_list()

song2.find_artist()

album5.song_count()

song7.find_by_track_number()

album5.song_by_track_number(5)

Artist.all()
Album.all()

binding.pry

nil