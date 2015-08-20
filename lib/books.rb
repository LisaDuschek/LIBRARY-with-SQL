class Books
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      name = book.fetch("name")
      id = book.fetch("id").to_i()
      books.push(Books.new({:name => name, :id => id}))
    end
    books

  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_book|
    self.name().==(another_book.name()).&(self.id().==(another_book.id()))
  end

  define_singleton_method(:find) do |id|
    found_book = nil
    Books.all().each() do |book|
      if book.id().==(id)
        found_book = book
      end
    end
    found_book
  end

  define_method(:patrons) do
    books_patrons = []
    patrons = DB.exec("SELECT * FROM patrons WHERE id = #{self.id()};")
    patrons.each() do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i()
      books_patrons.push(Patrons.new({:name => name, :id => id}))
    end
    books_patrons
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE books SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:patrons_ids, []).each() do |patron_id|
      DB.exec("INSERT INTO patrons_books (patron_id, book_id) VALUES (#{patron_id}, #{self.id()});")
  end
end

  define_method(:delete) do
    DB.exec("DELETE FROM patrons_books WHERE book_id = #{self.id()};")
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end

  define_method(:patrons) do
      book_patrons = []
      results = DB.exec("SELECT patron_id FROM patrons_books WHERE book_id = #{self.id()};")
      results.each() do |result|
      patron_id = result.fetch("patron_id").to_i()
      patron = DB.exec("SELECT * FROM patrons WHERE id = #{patron_id};")
      name = patron.first().fetch("name")
      book_patrons.push(Patrons.new({:name => name, :id => patron_id}))
    end
      book_patrons
  end


end
