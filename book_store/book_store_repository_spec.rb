require "book_store_repository"

def reset_books_table
  seed_sql = File.read('spec/seeds_book_store.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store' })
  connection.exec(seed_sql)
end

describe BookStoreRepository do
  before(:each) do 
    reset_books_table
  end

  # (your tests will go here).
end