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
      flash[:message] = "Sorry, you need to fill out all the fields below in order to create an account!"
      redirect "/users/new"
    end
  end

  post '/users/login' do
    # @user = User.find_by(username: params[:username])
    if @user = User.find_by(username: params[:username]) && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect "/users/#{@user.username}"
    else
      flash[:message] = "Sorry, we couldn't find that username/password combination! Please try again."
      redirect "/"
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
