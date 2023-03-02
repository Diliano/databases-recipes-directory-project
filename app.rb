require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')

recipe_repository = RecipeRepository.new

recipe_repository.all.each do |recipe|
  id = recipe.id
  name = recipe.name
  average_cooking_time = recipe.average_cooking_time
  rating = recipe.rating
  puts "#{id} - #{name} - #{average_cooking_time} - #{rating}"
end

recipe = recipe_repository.find(3)
id = recipe.id
name = recipe.name
average_cooking_time = recipe.average_cooking_time
rating = recipe.rating
puts "#{id} - #{name} - #{average_cooking_time} - #{rating}"