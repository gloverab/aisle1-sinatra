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

  def slug(name)
    no_punc.downcase.gsub(" ","-")
  end

end
