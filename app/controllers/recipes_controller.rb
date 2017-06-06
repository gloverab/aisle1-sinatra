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
    @recipe = current_user.recipes.build(name: params[:name], cooktime: params[:cooktime])
    if @recipe.save

      ingredient_names = ingredient_parser(params[:recipe][:ingredients])

      ingredient_ids_array = ingredient_names.collect do |ingredient|
        new_ingredient = Ingredient.find_or_create_by(name: ingredient.downcase)
        new_ingredient.id
      end

    @recipe.ingredient_ids=ingredient_ids_array
  end

    redirect "/recipes"
  end

  get '/recipes/:id/edit' do
    redirect to '/' if !logged_in?
    @recipe = Recipe.find_by_id(params[:id]) unless !logged_in?
    if @recipe && @recipe.user == current_user
      erb :'recipes/edit'
    else
      flash[:message] = "Sorry, you can only edit recipes that you've created!"
      redirect "/recipes"
    end
    # else
    #   # flash[:message] = "You must be logged in to view that (or pretty much any other) page!"
    #   redirect "/"
    # end
  end

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
    @recipe = Recipe.find_by_slug(params[:slug])
    if logged_in? && current_user.recipes.include?(@recipe)
      erb :'recipes/show'
    elsif !current_user.recipes.include?(@recipe)
      flash[:message] = "Sorry, you can only view recipes that you've created!"
      redirect "/recipes"
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
    @recipe = Recipe.find_by_id(params[:id])
    if current_user.recipes.include?(@recipe)
      recipe = Recipe.find_by_id(params[:id])
      recipe.delete
    else
      flash[:message] = "You can't delete recipes that aren't yours!"
    end
    redirect "/recipes"
  end

end
