# {{USERS}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_posts.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE users RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (name, email_address) VALUES ('andy6891', 'andy6891@gmail.com');
INSERT INTO users (name, email_address) VALUES ('john325', 'john325@hotmail.com');
INSERT INTO users (name, email_address) VALUES ('lisa678', 'lisa@hotmail.com');
INSERT INTO users (name, email_address) VALUES ('matt777', 'matt777@hotmail.com');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_users.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: users

# Model class
# (in lib/user.rb)
class User
end

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: users

# Model class
# (in lib/user.rb)

class User

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :email_address
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# user = User.new
# user.name = 'Jo'
# user.email_address = 'xxx@gmail.com'
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: users

# Repository class
# (in lib/user_repository.rb)

class UserRepository
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(user)
    # Executes the SQL query:

    # INSERT INTO users ( name, email_address) VALUES ( $1, $2);

  end
 
  def delete(id)
    # Executes the SQL query:

    # DELETE FROM users WHERE id = $1;
  end

  def update(user)
    # Executes the SQL query:

    # UPDATE users SET name = $1, email_address = $2 WHERE id = $3;
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all users

repo = UserRepository.new
users = repo.all

users.length # =>  4
users.first.id # =>  '1'
users.first.name # =>  'andy6891'
users.first.email_address # =>  'andy6891@gmail.com'
users[3].id # =>  '4'
users[3].name # =>  'matt777'
users[3].email_address # =>  'matt777@hotmail.com'

# 2
# Get a single user

repo = UserRepository.new

user = repo.find(2)

user.id # =>  2
user.name # =>  'john325'
user.email_address # =>  'john325@hotmail.com'

# 3
# Create a new user

repo = UserRepository.new
new_user = User.new
new_user.name = 'luis990'
new_user.email_address = 'luis990@gmail.com'

repo.create(new_user)

last_user = repo.all.last

last_user.name # => 'luis990'
last_user.email_address # => 'luis990@gmail.com'
last_user.id # => '5'

# 3
# Delete the first user

repo = UserRepository.new
repo.delete(1)

first_user = repo.all.first

first_user.name # => 'john325'
first_user.email_address # => 'john325@hotmail.com'
first_user.id # => '2'

# 4
# update the first user

repo = UserRepository.new
user_to_update = repo.find(1)
user_to_update.name = 'Céline'
user_to_update.email_address = 'celine88@gmail.com'

repo.update(user_to_update)
updated_user = repo.find(1)

updated_user.name # => 'Céline'
updated_user.email_address # => 'celine88@gmail.com' 


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_repository_spec.rb

def reset_user_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'users' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_user_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->