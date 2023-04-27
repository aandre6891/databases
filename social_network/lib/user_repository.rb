require 'user.rb'

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

  # # Gets a single record by its ID
  # # One argument: the id (number)
  # def find(id)
  #   # Executes the SQL query:
  #   # SELECT id, name, cohort_name FROM students WHERE id = $1;

  #   # Returns a single Student object.
  # end

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