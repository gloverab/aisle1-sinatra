require './config/environment'

class RecipesController < ApplicationController

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

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :'recipes/edit'
  end

  patch '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.update(name: params[:name]) unless params[:name].empty?
    @recipe.update(cooktime: params[:cooktime]) unless params[:cooktime].empty?

    if !params[:recipe][:ingredients].empty?
      ingredient_names = ingredient_parser(params[:recipe][:ingredients])
      ingredient_ids_array = ingredient_names.collect do |ingredient|
        new_ingredient = Ingredient.find_or_create_by(name: ingredient.downcase)
        new_ingredient.id
      end

      @recipe.ingredient_ids=ingredient_ids_array
    end

    redirect "/recipes/#{@recipe.slug}"
  end

  get '/recipes/:slug' do
    @recipe = Recipe.find_by_slug(params[:slug])
    erb :'recipes/show'
  end

  get '/recipes/add/:id' do
    recipe = Recipe.find_by(id: params[:id])
    current_week.recipes << recipe
    flash[:message] = "Successfully added #{recipe.name} to week of #{current_week.date}!"
    redirect "/recipes"
  end

  delete '/recipes/:id/delete' do
    recipe = Recipe.find_by_id(params[:id])
    recipe.delete
    redirect "/recipes"
  end

end
