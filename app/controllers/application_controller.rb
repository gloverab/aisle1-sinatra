require './config/environment'

class ApplicationController < Sinatra::Base
  include Helper
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
    register Sinatra::Flash
    enable :sessions
  end

  get '/' do
    if !logged_in?
      erb :'logged-out/index'
    else
      redirect "/users/#{current_user.username}"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end

end
