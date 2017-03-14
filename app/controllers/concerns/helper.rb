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

  def ingredients_with_dupe
    @duplicates = {}
    ingredients.each_with_index do |value, i|
      (i + 1).upto ingredients.length - 1 do |j|
        if ingredients[j] == value
          @duplicates[value] = [i] if @duplicates[value].nil?
          @duplicates[value] << j
          break
        end
      end
    end
  end

end
