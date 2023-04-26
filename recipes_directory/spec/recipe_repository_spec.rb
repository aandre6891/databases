# file: spec/recipe_repository_spec.rb
require 'recipe_repository'

RSpec.describe RecipeRepository do
  def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end

  describe RecipeRepository do
    before(:each) do 
      reset_recipes_table
    end
  end

  it "returns all recipes" do
    repo = RecipeRepository.new

    recipes = repo.all
    expect(recipes.length).to eq 5
    expect(recipes.first.id).to eq '1'
    expect(recipes.first.name).to eq 'Stir Fry Noodles'
    expect(recipes.first.average_cooking_time).to eq '30'
    expect(recipes.first.rating).to eq '5'

    expect(recipes[1].id).to eq '2'
    expect(recipes[1].name).to eq 'Baked Potato'
    expect(recipes[1].average_cooking_time).to eq '60'
    expect(recipes[1].rating).to eq '4'
  end
  
  
  it "returns a single recipe" do
    repo = RecipeRepository.new
    
    recipes = repo.find(1)
    expect(recipes.id).to eq '1'
    expect(recipes.name).to eq 'Stir Fry Noodles'
    expect(recipes.average_cooking_time).to eq '30'
    expect(recipes.rating).to eq '5'

  end
  
  it "returns another single recipe" do
    repo = RecipeRepository.new
    
    recipes = repo.find(3)
    expect(recipes.id).to eq '3'
    expect(recipes.name).to eq 'Carbonara'
    expect(recipes.average_cooking_time).to eq '30'
    expect(recipes.rating).to eq '4'
  end
end
