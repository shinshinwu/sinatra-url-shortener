get '/' do
  @urls = Url.all
  erb :index
end


# ------------- SESSIONS --------------

# once a user has signed in they should be redirected to the session page with just their urls that have been stored

# shows sign in page
get '/sessions/new' do
  erb :sign_in
end

# actually sign user in if locate user and render post sign in contents
post '/sessions' do
  if user = User.authenticate(params)
    session[:user_id] = user.id
    redirect "/sessions/#{user.id}"
  else
    @errors = user.errors.messages
    erb :sign_in
  end
end

get '/sessions/:user_id' do
  @user = User.find(params[:user_id])
  @urls = @user.urls
  erb :show
end

post '/sessions/:user_id/urls' do
  @new_url = Url.create(original_address: params[:original_address], user_id: params[:user_id])
  redirect "/sessions/#{params[:user_id]}"
end

# sign out user
delete '/sessions/:id' do
  session[:user_id] = nil
  redirect '/'
end


# ------------- USERS ---------------

# render sign-up page
get '/users/new' do
  erb :sign_up
end

# create new user and redirect to user homepage
post '/users' do
  user = User.create(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect "/sessions/#{user.id}" # (need to implement user url page)
  else
    @errors = user.errors.messages
    erb :sign_in
  end
end


# need to adapt below to include user sessions
get '/:short_url' do
  @url = Url.find_by(slug: params[:short_url])
  @url.click_count =+ 1
  @url.save
  redirect "#{@url.original_address}"
end



