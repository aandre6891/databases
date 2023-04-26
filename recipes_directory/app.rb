require_relative "lib/recipe_repository"
require_relative "lib/database_connection"

DatabaseConnection.connect('recipes_directory')

recipe_repository = RecipeRepository.new
recipe = Recipe.new

recipe_repository.all.each do |record|
    p "name: #{record.name}, rating: #{record.rating}"
end

record = recipe_repository.find(1)
p record.name





