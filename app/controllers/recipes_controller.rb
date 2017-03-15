require './config/environment'

class RecipesController < ApplicationController

  get '/recipes/new' do
    if logged_in?
      erb :'recipes/new'
    else
      flash[:message] = "You must be logged in to view that (or pretty much any other) page!"
      redirect "/"
    end
  end

  get '/recipes' do
    if logged_in?
      erb :'recipes/index'
    else
      flash[:message] = "You must be logged in to view that (or pretty much any other) page!"
      redirect "/"
    end
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
    if logged_in?
      @recipe = Recipe.find_by_id(params[:id])
      erb :'recipes/edit'
    else
      flash[:message] = "You must be logged in to view that (or pretty much any other) page!"
      redirect "/"
    end
  end

  # patch '/recipes/:id/edit' do
  #   @recipe = Recipe.find_by_id(params[:id])
  #   @recipe.update(name: params[:name]) unless params[:name].empty?
  #   @recipe.update(cooktime: params[:cooktime]) unless params[:cooktime].empty?
  #
  #   if !params[:recipe][:ingredients].empty?
  #     ingredient_names = ingredient_parser(params[:recipe][:ingredients])
  #     ingredient_ids_array = ingredient_names.collect do |ingredient|
  #       new_ingredient = Ingredient.find_or_create_by(name: ingredient.downcase)
  #       new_ingredient.id
  #     end
  #     @recipe.ingredient_ids=ingredient_ids_array
  #   end
  #
  #   redirect "/recipes/#{@recipe.slug}"
  # end

  patch '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe.update(name: params[:name], cooktime: params[:cooktime])
      if !params[:recipe][:ingredients].empty?
        ingredient_names = ingredient_parser(params[:recipe][:ingredients])
        ingredient_ids_array = ingredient_names.collect do |ingredient|
          new_ingredient = Ingredient.find_or_create_by(name: ingredient.downcase)
          new_ingredient.id
        end
        @recipe.ingredient_ids=ingredient_ids_array
      end
   		flash[:message] = "You've successfully updated #{@recipe.name}"
		  redirect "/recipes/#{@recipe.slug}"
  	else
  		flash[:message] = @recipe.errors.full_messages
  		erb :'recipes/edit'
  	end
  end

  get '/recipes/:slug' do
    if logged_in?
      @recipe = Recipe.find_by_slug(params[:slug])
      erb :'recipes/show'
    else
      flash[:message] = "You must be logged in to view that (or pretty much any other) page!"
      redirect "/"
    end
  end

  get '/recipes/add/:id' do
    if logged_in? && current_week
      recipe = Recipe.find_by(id: params[:id])
      current_week.recipes << recipe
      flash[:message] = "Successfully added #{recipe.name} to week of #{current_week.date}!"
      redirect "/recipes"
    elsif logged_in? && !current_week
      flash[:message] = "Please select or create a week so you can add a recipe to it!"
      redirect "/weeks"
    else
      flash[:message] = "You must be logged in to view that (or pretty much any other) page!"
      redirect "/"
    end
  end

  delete '/recipes/:id/delete' do
    recipe = Recipe.find_by_id(params[:id])
    recipe.delete
    redirect "/recipes"
  end

end
