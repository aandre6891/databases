require_relative "lib/recipe_repository"
require_relative "lib/database_connection"

DatabaseConnection.connect('recipes_directory')

recipe_repository = RecipeRepository.new

puts "All the recipes:"
recipe_repository.all.each do |record|
    p "#{record.id}. #{record.name} - Time: #{record.average_cooking_time} mins - Rating: #{record.rating}"
end

puts "-----------------------\nJust the first recipe:"

record = recipe_repository.find(1)
p "#{record.id}. #{record.name} - Time: #{record.average_cooking_time} mins - Rating: #{record.rating}"





