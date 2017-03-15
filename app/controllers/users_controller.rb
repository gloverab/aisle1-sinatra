require './config/environment'

class UsersController < ApplicationController

  get '/users/new' do
      erb :'users/new'
  end

  post '/users/new' do
    # binding.pry
    user = User.new(params)
    if user.save
      session[:id] = user.id
      redirect "/users/#{user.username}"
    else
      redirect "/"
    end
  end

  post '/users/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect "/users/#{@user.username}"
    end
  end

  get '/users/weeks' do
    if logged_in?
      erb :'weeks/index'
    else
      flash[:message] = "You must be logged in to view that (or pretty much any other) page!"
      redirect "/"
    end
  end

  post '/weeks/new' do
    week = Week.new(params)
    week.user_id = current_user.id
    week.save
    session[:week] = week.id

    redirect "/users/weeks"
  end

  get '/users/:username' do
    if logged_in?
      @user = User.find_by(username: params[:username])
      erb :'users/home'
    else
      flash[:message] = "You must be logged in to view that (or pretty much any other) page!"
      redirect "/"
    end
  end

end
