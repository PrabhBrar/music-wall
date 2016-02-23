# Homepage (Root path)
enable :sessions

get '/' do
  session["value"] ||= "Hello world!"
  "The cookie you've created contains the value: #{session["value"]}"
  #erb :index
end

get '/users' do
  if session["user_id"]
    @user = User.find(session["user_id"])
    @songs = Song.all
    erb :'songs/index'
  else
    @user = User.new
    erb :'users/index'
  end
end

get '/songs' do
  if session["user_id"]
    @user = User.find(session["user_id"])
    @songs = Song.all
    erb :'songs/index'
  else
    erb :'users/index'
  end
end

get '/songs/new_song' do
  if session["user_id"]
    @song = Song.new
    @user = User.find(session["user_id"])
    erb :'songs/new_song'
  else
    erb :'users/index'
  end
end

get '/songs/upvote/:id' do
  if session["user_id"]
    @user = User.find(session["user_id"])
    @vote = Vote.new(user_id: @user.id, song_id: params[:id])
    @vote.save
    @songs = Song.all
    erb :'songs/index'
  else
    erb :'users/index'
  end
end

get '/users/new_user' do
  @user = User.new
  erb :'users/new_user'
end

post '/songs' do
  @song = Song.new(
    song_title: params[:song_title],
    author: params[:author],
    song_url: params[:song_url],
    user_id: session["user_id"]
  )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new_song'
  end
end

post '/login' do
  @user = User.where("email = ? AND password = ?", params[:email], params[:password])[0]
  if @user
    session["user_id"] ||= @user.id
    redirect '/songs'
  else
    @user = User.new
    @user.errors.add(:invalid_user, 'Invalid Email or Password')
    erb :'users/index'
  end
end

post '/users/new_user' do
  @user = User.new(
    email: params[:email],
    password: params[:password],
    name: params[:name]
  )
  if @user.save
    session["user_id"] ||= @user.id
    redirect '/songs'
  else
    erb :'users/new_user'
  end
end

get '/users/logout' do
  session.clear
  @user = User.new
  erb :'users/index'
end