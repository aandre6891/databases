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

  def find(id)
    sql = "SELECT id, title, content, number_of_views, user_id FROM posts WHERE id = $1;"
    post_id = [id]
    result_set = DatabaseConnection.exec_params(sql, post_id)

    selected_post = result_set[0]
    post = Post.new
    post.id = selected_post['id']
    post.title = selected_post['title']
    post.content = selected_post['content']
    post.number_of_views = selected_post['number_of_views']
    post.user_id = selected_post['user_id']
    return post
  end

  def create(post) # returns nothing
    sql = "INSERT INTO posts ( title, content, number_of_views, user_id) VALUES ( $1, $2, $3, $4);"
    params = [post.title, post.content, post.number_of_views, post.user_id]
    DatabaseConnection.exec_params(sql, params)
  end
 
  def delete(id) # returns nothing
    sql = "DELETE FROM posts WHERE id = $1;"
    post_id = [id]
    DatabaseConnection.exec_params(sql, post_id)
  end

  def update(post) # returns nothing
    sql = "UPDATE posts SET title = $1, content = $2, 
    number_of_views = $3, user_id = $4 WHERE id = $5;"
    params = [post.title, post.content, post.number_of_views, post.user_id, post.id]
    DatabaseConnection.exec_params(sql, params)
  end
end