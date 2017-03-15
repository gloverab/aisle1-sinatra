require './config/environment'

class WeeksController < ApplicationController

  get "/weeks" do
    if logged_in?
      erb :'weeks/index'
    else
      flash[:message] = "You must be logged in to view that (or pretty much any other) page!"
      redirect "/"
    end
  end

  get "/weeks/:id/add" do
    if logged_in?
    session[:week] = params[:id]

    redirect "/recipes"
    else
      flash[:message] = "You must be logged in to view that (or pretty much any other) page!"
      redirect "/"
    end
  end

  get "/weeks/show" do
    if logged_in?
      erb :'weeks/show'
    else
      flash[:message] = "You must be logged in to view that (or pretty much any other) page!"
      redirect "/"
    end
  end

  get "/weeks/recipe/:id/delete" do
    if logged_in?
      recipe = Recipe.find_by_id(params[:id])
      current_week.recipes.delete(recipe)

      redirect "/weeks/show"
    else
      flash[:message] = "You must be logged in to view that (or pretty much any other) page!"
      redirect "/"
    end
  end

  get "/weeks/:id/delete" do
    if logged_in?
      week = Week.find_by_id(params[:id])
      week.delete

      redirect "/weeks"
    else
      flash[:message] = "You must be logged in to view that (or pretty much any other) page!"
      redirect "/"
    end
  end

end
