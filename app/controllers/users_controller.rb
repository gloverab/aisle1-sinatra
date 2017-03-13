require './config/environment'

class UsersController < ApplicationController

  include Helper

  get '/users/:username' do
    @user = User.find_by(username: params[:username])
    erb :'user/index'
  end

  post '/recipe/new' do
    # binding.pry
    @recipe = Recipe.new(
    name: params[:name],
    cooktime: params[:cooktime],
    user_id: current_user.id
    )
    @ingredients = ingredient_parser(params[:recipe][:ingredients])
    @ingredients.each do |ingredient|
      # binding.pry
      new_ingredient = Ingredient.find_or_create_by(name: ingredient.downcase)
      
      @recipe.ingredients
    end
    # binding.pry
    erb :'user/index'
  end

end
