require_relative "../lib/book_store_repository"

RSpec.describe BookStoreRepository do
  describe BookStoreRepository do
    def reset_books_table
      seed_sql = File.read('spec/seeds_book_store.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store' })
      connection.exec(seed_sql)
    end

    before(:each) do 
      reset_books_table
    end

    it "" do
      repo = BookStoreRepository.new

      books = repo.all
      
      expect(books.length).to eq 2
      expect(books[0].id).to eq "1"
      expect(books[0].title).to eq 'Pride & Prejudice'
      expect(books[0].author_name).to eq 'Jane Austin'
      expect(books[1].id).to eq 2
      expect(books[1].title).to eq 'The count of Montecristo'
      expect(books[1].author_name).to eq 'Alexandre Dumas'
    end
  end
end