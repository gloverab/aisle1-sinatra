module Helper

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def ingredient_parser(ingredients)
    ingredients.split(/\s*,\s*/)
  end

  def current_week
    @current_week ||= Week.find_by(id: session[:week_id]) if session[:week_id]
  end

end
