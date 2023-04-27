# Albums model and repository class design

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
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year, artist_id) VALUES ( 'Doolittle', '1989', '1' );
INSERT INTO albums (title, release_year, artist_id) VALUES ( 'Waterloo', '1974', '2' );
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/albums.rb)
class Albums
end

# Repository class
# (in lib/albums_repository.rb)
class AlbumsRrepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Albums

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :release_year, :artist_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: albums

# Repository class
# (in lib/albums_repository.rb)

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;

    # Returns an array of Albums objects.
  end

  def find
    # Executes the SQL query:

    # SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;
  end

  def create(album)
    # Executes the SQL query:

    # INSERT INTO albums title, release_year, artist_id) VALUES ( 'Trompe le Monde', '1991', '1' );
  end

  def delete(id)
    # Executes the SQL query:

    # DELETE FROM albums WHERE id = $1;
  end

  def update(album)
    # Executes the SQL query:

    # UPDATE albums SET title = $1, release_year = $2, artist_id = $3 WHERE id = $4;
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all albums

repo = AlbumsRepository.new

albums = repo.all

albums.length # =>  2

albums[0].id # =>  1
albums.first.title # =>  'Doolittle'
albums[1].release_year # =>  '1974'
albums[1].artist_id # =>  '2'

# 2
# Get the first album 'Doolittle'

repo = AlbumsRepository.new
albums = repo.find(1)

albums.title # => 'Doolittle'
albums.release_year # => '1989'
albums.artist_id # => '1'

# 3
# get the album Baltimore

repo = AlbumsRepository.new
albums = repo.find(2)

albums.title # => 'Waterloo'
albums.release_year # => '1974'
albums.artist_id # => '2'

# 4
# inserts the new album Cross Road

repo = AlbumsRepository.new

album = Albums.new
album.title = 'Trompe le Monde'
album.release_year = 1991
album.artist_id = 1

repo.create(album)

all_albums = repo.all
last_album = all_albums.last

last_album.title # => 'Trompe le Monde'
last_album.release_year # => '1991'
last_album.artist_id # => '1'

# 5
# it deletes 'Doolittle' from the albums

repo = AlbumsRepository.new

repo.delete(1)

all_albums = repo.all

all_albums.length # => 1
all_albums.first.id # => '2'

# 6
# it updates 'Doolittle' into 'Trompe le Monde' and release year into 1991

repo = AlbumsRepository.new

album = repo.find(1)
album.name = 'Trompe le Monde'
album.release_year = '1991'

repo.update(album)

updated_album = repo.find(1)

update_album.name # => 'Trompe le Monde'
updated_album.release_year # => '1991'
updated_album.artist_id # => '1'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/albums_repository_spec.rb

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'musicl_library_test' })
  connection.exec(seed_sql)
end

describe AlbumsRepository do
  before(:each) do 
    reset_albums_table
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