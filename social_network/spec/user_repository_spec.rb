require_relative '../lib/user_repository'
require_relative '../lib/database_connection'

RSpec.describe UserRepository do
  def reset_user_table
    seed_sql = File.read('spec/seeds_users.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  describe UserRepository do
    before(:each) do 
      reset_user_table
    end
  
    it "gets all the users" do

      repo = UserRepository.new
      users = repo.all

      expect(users.length).to eq 4
      expect(users.first.id).to eq '1'
      expect(users.first.name).to eq 'andy6891'
      expect(users.first.email_address).to eq 'andy6891@gmail.com'
      expect(users[3].id).to eq '4'
      expect(users[3].name).to eq 'matt777'
      expect(users[3].email_address).to eq 'matt777@hotmail.com'
    end

    it "gets the second user only" do

      repo = UserRepository.new
      user = repo.find(2)

      expect(user.id).to eq '2'
      expect(user.name).to eq 'john325'
      expect(user.email_address).to eq 'john325@hotmail.com'
    end
  end
end

# # 3
# # Create a new user

# repo = UserRepository.new
# new_user = User.new
# new_user.name = 'luis990'
# new_user.email_address = 'luis990@gmail.com'

# repo.create(new_user)

# last_user = repo.all.last

# last_user.name # => 'luis990'
# last_user.email_address # => 'luis990@gmail.com'
# last_user.id # => '5'

# # 4
# # Delete the first user

# repo = UserRepository.new
# repo.delete(1)

# first_user = repo.all.first

# first_user.name # => 'john325'
# first_user.email_address # => 'john325@hotmail.com'
# first_user.id # => '2'

# # 5
# # update the first user

# repo = UserRepository.new
# user_to_update = repo.find(1)
# user_to_update.name = 'Céline'
# user_to_update.email_address = 'celine88@gmail.com'

# repo.update(user_to_update)
# updated_user = repo.find(1)

# updated_user.name # => 'Céline'
# updated_user.email_address # => 'celine88@gmail.com' 