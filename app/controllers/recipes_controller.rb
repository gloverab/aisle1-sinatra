require './config/environment'

class RecipesController < ApplicationController

  include Helper

  get '/recipes/new' do
    erb :'recipes/new'
  end

  get '/recipes' do
    erb :'recipes/index'
  end

  post '/recipes' do
    # binding.pry
    @recipe = Recipe.new(
    name: params[:name],
    cooktime: params[:cooktime],
    user_id: current_user.id
    )
    @recipe.save

    ingredient_names = ingredient_parser(params[:recipe][:ingredients])
    ingredient_ids_array = ingredient_names.collect do |ingredient|
      new_ingredient = Ingredient.find_or_create_by(name: ingredient.downcase)
      new_ingredient.id
    end

    @recipe.ingredient_ids=ingredient_ids_array

    redirect "/recipes"
  end

end
