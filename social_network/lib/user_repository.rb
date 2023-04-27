require 'user.rb'
require 'database_connection'

class UserRepository
  def all
    # Executes the SQL query:
    sql = "SELECT id, name, email_address FROM users;"
    result_set = DatabaseConnection.exec_params(sql, [])

    users = []

    result_set.each do |record|
      user = User.new
      user.id = record['id']
      user.name = record['name']
      user.email_address = record['email_address']

      users << user
    end
    return users
  end

  def find(id)
    sql = "SELECT id, name, email_address FROM users WHERE id = $1;"
    user_id = [id]
    result_set = DatabaseConnection.exec_params(sql, user_id)

    user_result = result_set[0]
    user = User.new
    user.id = user_result['id']
    user.name = user_result['name']
    user.email_address = user_result['email_address']
    return user
  end

  def create(user) # does not return anything

    sql = "INSERT INTO users ( name, email_address) VALUES ( $1, $2);"
    params = [user.name, user.email_address] 
    DatabaseConnection.exec_params(sql, params)
  end
 
  def delete(id) # does not return anything
    sql = "DELETE FROM users WHERE id = $1;"
    user_to_delete = [id]
    DatabaseConnection.exec_params(sql, user_to_delete)
  end

  def update(user) # does not return anything
    sql = "UPDATE users SET name = $1, email_address = $2 WHERE id = $3;"
    params = [user.name, user.email_address, user.id]
    DatabaseConnection.exec_params(sql, params)
  end
end