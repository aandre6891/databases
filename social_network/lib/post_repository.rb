require_relative "database_connection"
require_relative "post"

class PostRepository
  def all
    sql = "SELECT id, title, content, number_of_views, user_id FROM posts;"
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.number_of_views = record['number_of_views']
      post.user_id = record['user_id']

      posts << post
    end
    return posts
  end

  # # Gets a single record by its ID
  # # One argument: the id (number)
  # def find(id)
  #   # Executes the SQL query:
  #   # SELECT id, title, content, number_of_views, user_id FROM users WHERE id = $1;

  #   # Returns a single Post object.
  # end

  # # Add more methods below for each operation you'd like to implement.

  # def create(post)
  #   # Executes the SQL query:

  #   # INSERT INTO users ( title, content, number_of_views, user_id) VALUES ( $1, $2, $3, $4);

  # end
 
  # def delete(id)
  #   # Executes the SQL query:

  #   # DELETE FROM posts WHERE id = $1;
  # end

  # def update(post)
  #   # Executes the SQL query:

  #   # UPDATE users SET name = $1, content = $2, number_of_views = $3, user_id = $4 WHERE id = $5;
  # end

end