require './config/environment'

class UsersController < ApplicationController

  include Helper

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

  get '/users/:test' do
    @name = "Captain's super famouse douchey&boy chicken"
    binding.pry
  end

  get '/users/:username' do
    @user = User.find_by(username: params[:username])
    erb :'users/home'
  end

end
