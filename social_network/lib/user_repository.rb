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

  # # Add more methods below for each operation you'd like to implement.

  # def create(user)
  #   # Executes the SQL query:

  #   # INSERT INTO users ( name, email_address) VALUES ( $1, $2);

  # end
 
  # def delete(id)
  #   # Executes the SQL query:

  #   # DELETE FROM users WHERE id = $1;
  # end

  # def update(user)
  #   # Executes the SQL query:

  #   # UPDATE users SET name = $1, email_address = $2 WHERE id = $3;
  # end

end