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

  it "gets a single post" do
    repo = PostRepository.new
    post = repo.find(2)

    expect(post.id).to eq "2"
    expect(post.title).to eq 'Title 2'
    expect(post.content).to eq 'content 2'
    expect(post.number_of_views).to eq '54'
    expect(post.user_id).to eq '2'
  end

  it "creates a new post" do
    repo = PostRepository.new
    new_post = Post.new
    new_post.title = 'Title 5'
    new_post.content = 'content 5'
    new_post.number_of_views = '55'
    new_post.user_id = '3'

    repo.create(new_post)

    last_post = repo.all.last

    expect(repo.all.length).to eq 5
    expect(last_post.id).to eq '5'
    expect(last_post.title).to eq 'Title 5'
    expect(last_post.content).to eq 'content 5'
    expect(last_post.number_of_views).to eq '55'
    expect(last_post.user_id).to eq '3'
  end

  it "deletes the first post" do
    repo = PostRepository.new
    repo.delete(1)

    posts = repo.all

    expect(posts.length).to eq 3
  end

  it "updates the first post" do
    repo = PostRepository.new
    post_to_update = repo.find(1)
    post_to_update.title = 'Title 4.2'
    post_to_update.content = 'content 4.2'
    post_to_update.number_of_views = '44'
    post_to_update.user_id = '4'

    repo.update(post_to_update)
    updated_post = repo.find(1)

    expect(updated_post.title).to eq 'Title 4.2'
    expect(updated_post.content).to eq 'content 4.2'
    expect(updated_post.number_of_views).to eq '44'
    expect(updated_post.user_id).to eq '4'
  end
end