require_relative "../lib/post_repository"

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  it "gets all posts" do
    repo = PostRepository.new
    posts = repo.all

    expect(posts.length).to eq 4
    expect(posts.first.id).to eq '1'
    expect(posts.first.title).to eq 'Title 1'
    expect(posts.first.content).to eq 'content 1'
    expect(posts.first.number_of_views).to eq '45'
    expect(posts.first.user_id).to eq '1'

    expect(posts[3].id).to eq '4'
    expect(posts[3].title).to eq 'Title 4'
    expect(posts[3].content).to eq 'content 4'
    expect(posts[3].number_of_views).to eq '32'
    expect(posts[3].user_id).to eq '4'
  end

end

# # 2
# # Get a single post

# repo = PostRepository.new

# post = repo.find(2)

# post.id # =>  2
# post.title # =>  'Title 2'
# post.content # =>  'content 2'
# post.number_of_views # =>  '54'
# post.user_id # =>  '2'

# # 3
# # Create a new post

# repo = PostRepository.new
# new_post = Post.new
# new_post.title = 'Title 5'
# new_post.content = 'content 5'
# new_post.number_of_views = '55'
# new_post.user_id = '3'

# repo.create(new_post)

# last_post = repo.all.last

# repo.all.length #=> 5
# last_post.id # => '5'
# last_post.title # => 'Title 5'
# last_post.content # => 'content 5'
# last_post.number_of_views # => '55'
# last_post.user_id # => '3'

# # 4
# # Delete the first post

# repo = UserRepository.new
# repo.delete(1)

# posts = repo.all

# posts.length # => 3

# # 5
# # update the first post

# repo = UserRepository.new
# post_to_update = repo.find(1)
# post_to_update.title = 'Title 4.2'
# post_to_update.content = 'content 4.2'
# post_to_update.number_of_views = '44'
# post_to_update.user_id = '4'

# repo.update(user_to_update)
# updated_user = repo.find(1)

# updated_user.title # => 'Title 4.2'
# updated_user.content # => 'content 4.2'
# updated_user.number_of_views # => '44'
# updated_user.user_id # => '4'