# Recipes Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_recipes.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('pasta', '20', '5');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('pizza', '60', '5');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('sandwich', '5', '3');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 recipes_directory_test < seeds_recipes.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: recipes

# Model class
# (in lib/recipe.rb)
class Recipe
end

# Repository class
# (in lib/recipe_repository.rb)
class RecipeRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: recipes

# Model class
# (in lib/recipe.rb)

class Recipe
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :average_cooking_time, :rating
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: recipes

# Repository class
# (in lib/recipe_repository.rb)

class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, average_cooking_time, rating FROM recipes;

    # Returns an array of Recipe objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, average_cooking_time, rating FROM recipes WHERE id = $1;

    # Returns a single Recipe object.
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all recipes

repo = RecipeRepository.new

recipes = repo.all

recipes.length # =>  2

recipes[0].name # => 'pasta'
recipes[0].average_cooking_time # => '20'
recipes[0].rating # => '5'

recipes[1].name # => 'pizza'
recipes[1].average_cooking_time # => '60'
recipes[1].rating # => '5'

recipes[2].name # => 'sandwich'
recipes[2].average_cooking_time # => '5'
recipes[2].rating # => '3'

# 2
# Get a single recipe when given id value 1

repo = RecipeRepository.new

recipe = recipe.find(1)

recipe.id # => '1'
recipe.name # => 'pasta'
recipe.average_cooking_time # => '20'
recipe.rating # => '5'

# 3
# Get a single recipe when given id value 3

repo = RecipeRepository.new

recipe = recipe.find(3)

recipe.id # => '3'
recipe.name # => 'sandwich'
recipe.average_cooking_time # => '5'
recipe.rating # => '3'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/recipe_repository_spec.rb

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

