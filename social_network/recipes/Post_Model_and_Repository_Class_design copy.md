# {{POSTS}} Model and Repository Classes Design Recipe

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

TRUNCATE TABLE posts RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Title 1', 'content 1', '45', '1');
INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Title 2', 'content 2', '54', '2');
INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Title 3', 'content 3', '81', '3');
INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Title 4', 'content 4', '32', '4');
`` 4
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_users.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :numner_of_views, :user_id
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
# (in lib/post_repository.rb)

class PostRepository
  def all
    # Executes the SQL query:
    # SELECT id, title, content, number_of_views, user_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, number_of_views, user_id FROM users WHERE id = $1;

    # Returns a single Post object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(post)
    # Executes the SQL query:

    # INSERT INTO users ( title, content, number_of_views, user_id) VALUES ( $1, $2, $3, $4);

  end
 
  def delete(id)
    # Executes the SQL query:

    # DELETE FROM posts WHERE id = $1;
  end

  def update(post)
    # Executes the SQL query:

    # UPDATE users SET name = $1, content = $2, number_of_views = $3, user_id = $4 WHERE id = $5;
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all posts

repo = PostRepository.new
posts = repo.all
posts.length # =>  4
posts.first.id # =>  '1'
posts.first.title # =>  'Title 1'
posts.first.content # =>  'content 1'
posts.first.number_of_views # =>  '45'
posts.first.user_id # =>  '1'
posts[3].id # =>  '4'
posts[3].title # =>  'Title 4'
posts[3].content # =>  'content 4'
posts[3].number_of_views # =>  '32'
posts[3].user_id # =>  '4'

# 2
# Get a single post

repo = PostRepository.new

post = repo.find(2)

post.id # =>  2
post.title # =>  'Title 2'
post.content # =>  'content 2'
post.number_of_views # =>  '54'
post.user_id # =>  '2'

# 3
# Create a new post

repo = PostRepository.new
new_post = Post.new
new_post.title = 'Title 5'
new_post.content = 'content 5'
new_post.number_of_views = '55'
new_post.user_id = '3'

repo.create(new_post)

last_post = repo.all.last

repo.all.length #=> 5
last_post.id # => '5'
last_post.title # => 'Title 5'
last_post.content # => 'content 5'
last_post.number_of_views # => '55'
last_post.user_id # => '3'

# 4
# Delete the first post

repo = UserRepository.new
repo.delete(1)

posts = repo.all

posts.length # => 3

# 5
# update the first post

repo = UserRepository.new
post_to_update = repo.find(1)
post_to_update.title = 'Title 4.2'
post_to_update.content = 'content 4.2'
post_to_update.number_of_views = '44'
post_to_update.user_id = '4'

repo.update(user_to_update)
updated_user = repo.find(1)

updated_user.title # => 'Title 4.2'
updated_user.content # => 'content 4.2'
updated_user.number_of_views # => '44'
updated_user.user_id # => '4'


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
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