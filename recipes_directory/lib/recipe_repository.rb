require_relative './recipe'

class RecipeRepository

    # Selecting all records
    # No arguments
    def all
      sql = 'SELECT id, name, average_cooking_time, rating FROM recipes;'
      result = DatabaseConnection.exec_params(sql, [])

      recipes = []

      result.each do |record|
        recipe = Recipe.new
        recipe.id = record['id']
        recipe.name = record['name']
        recipe.average_cooking_time = record['average_cooking_time']
        recipe.rating = record['rating']

        recipes << recipe
      end
      return recipes
    end
  
    def find(id)
      sql = "SELECT id, name, average_cooking_time, rating FROM recipes WHERE id = $1;"
      result = DatabaseConnection.exec_params(sql, [id])
  
      record = result[0]
      recipe = Recipe.new
      recipe.id = record['id']
      recipe.name = record['name']
      recipe.average_cooking_time = record['average_cooking_time']
      recipe.rating = record['rating']

      return recipe
    end
end