require_relative "lib/book_store_repository"
require_relative "lib/database_connection"

DatabaseConnection.connect('book_store')

book_store_repository = BookStoreRepository.new
book_store_repository.all.each do |book|
  p "#{book.id} - #{book.title} - #{book.author_name}"
end