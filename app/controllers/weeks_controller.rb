require './config/environment'

class WeeksController < ApplicationController

  get "/weeks" do
    erb :'weeks/index'
  end

  get "/weeks/:id/add" do
    session[:week] = params[:id]

    redirect "/recipes"
  end

  get "/weeks/show" do
    erb :'weeks/show'
  end

  get "/weeks/recipe/:id/delete" do
    recipe = Recipe.find_by_id(params[:id])
    current_week.recipes.delete(recipe)

    redirect "/weeks/show"
  end

  get "/weeks/:id/delete" do
    week = Week.find_by_id(params[:id])
    week.delete

    redirect "/weeks"
  end

end
