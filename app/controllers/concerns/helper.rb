module Helper

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:id]) if session[:id]
  end

  def ingredient_parser(ingredients)
    ingredients.split(/\s*,\s*/)
    # binding.pry
  end

  def current_week
    @current_week ||= Week.find_by(id: session[:week]) if session[:week]
  end

end
