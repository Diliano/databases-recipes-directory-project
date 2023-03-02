require 'recipe_repository'

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

RSpec.describe RecipeRepository do

  before(:each) do 
    reset_recipes_table
  end
  
  it "returns all of the recipes" do
    repo = RecipeRepository.new

    recipes = repo.all

    expect(recipes.length).to eq 3

    expect(recipes[0].name).to eq 'pasta'
    expect(recipes[0].average_cooking_time).to eq '20'
    expect(recipes[0].rating).to eq '5'

    expect(recipes[1].name).to eq 'pizza'
    expect(recipes[1].average_cooking_time).to eq '60'
    expect(recipes[1].rating).to eq '5'

    expect(recipes[2].name).to eq 'sandwich'
    expect(recipes[2].average_cooking_time).to eq '5'
    expect(recipes[2].rating).to eq '3'
  end

  context "returns a single recipe when given an id value" do
    it "returns pasta recipe when given an id of 1" do
      repo = RecipeRepository.new

      recipe = repo.find(1)

      expect(recipe.id).to eq '1'
      expect(recipe.name).to eq 'pasta'
      expect(recipe.average_cooking_time).to eq '20'
      expect(recipe.rating).to eq '5'
    end
    it "returns sandwich recipe when given an id of 3" do
      repo = RecipeRepository.new

      recipe = repo.find(3)

      expect(recipe.id).to eq '3'
      expect(recipe.name).to eq 'sandwich'
      expect(recipe.average_cooking_time).to eq '5'
      expect(recipe.rating).to eq '3'
    end
  end
  
end