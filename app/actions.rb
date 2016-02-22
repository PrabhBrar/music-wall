# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new_song' do
  @song = Song.new
  erb :'songs/new_song'
end

post '/songs' do
  @song = Song.new(
    song_title: params[:song_title],
    author: params[:author],
    song_url: params[:song_url]
  )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new_song'
  end
end