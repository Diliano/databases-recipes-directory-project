require_relative 'recipe'

class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    recipes = []
    # Executes the SQL query:
    sql = 'SELECT id, name, average_cooking_time, rating FROM recipes;'
    
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      recipe = Recipe.new
      recipe.id = record['id']
      recipe.name = record['name']
      recipe.average_cooking_time = record['average_cooking_time']
      recipe.rating = record['rating']
      recipes << recipe
    end
    # Returns an array of Recipe objects.
    return recipes
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, name, average_cooking_time, rating FROM recipes WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    recipe = Recipe.new
    recipe.id = record['id']
    recipe.name = record['name']
    recipe.average_cooking_time = record['average_cooking_time']
    recipe.rating = record['rating']
    # Returns a single Recipe object.
    return recipe
  end

end