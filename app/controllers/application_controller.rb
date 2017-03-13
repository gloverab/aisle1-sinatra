require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/new_user' do
    # binding.pry
    user = User.new(params)
    if user.save
      session[:id] = user.id
      redirect "/users/#{user.username}"
    else
      redirect "/"
    end
  end

end
