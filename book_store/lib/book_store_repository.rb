require_relative "book_store"

class BookStoreRepository
  def all
    sql = "SELECT id, title, author_name FROM books ORDER BY id ASC;"
    selection = DatabaseConnection.exec_params(sql, [])

    books = []

    selection.each do |element|
      book = BookStore.new
      book.id = element["id"]
      book.title = element["title"]
      book.author_name = element["author_name"]
      
      books << book
    end

    return books
  end
end