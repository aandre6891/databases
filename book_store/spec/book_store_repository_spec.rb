require_relative "../lib/book_store_repository"

RSpec.describe BookStoreRepository do
  describe BookStoreRepository do
    def reset_books_table
      seed_sql = File.read('spec/seeds_book_store.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
      connection.exec(seed_sql)
    end

    before(:each) do 
      reset_books_table
    end

    it "" do
      repo = BookStoreRepository.new

      books = repo.all
      
      expect(books.length).to eq 5
      expect(books[0].id).to eq "1"
      expect(books[0].title).to eq 'Nineteen Eighty-Four'
      expect(books[0].author_name).to eq 'George Orwell'
      expect(books[2].id).to eq "3"
      expect(books[3].title).to eq 'Dracula'
      expect(books[4].author_name).to eq 'Edith Wharton'
    end
  end
end