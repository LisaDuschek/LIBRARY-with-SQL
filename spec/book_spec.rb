require("spec_helper")

describe(Books) do
  describe(".all") do
    it("starts off with no books") do
    expect(Books.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      book = Books.new({:name => "Programming", :id => nil})
      expect(book.name()).to(eq("Programming"))
    end
  end

  describe ("#id") do
    it("sets its ID when you save it") do
      book = Books.new({:name => "Programming", :id => nil})
      book.save()
      expect(book.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save books to the database") do
      book = Books.new({:name => "Programming", :id => nil})
      book.save()
      expect(Books.all()).to(eq([book]))
    end
  end

  describe("#==") do
    it("is the same book if it has the same name") do
      book1 = Books.new({:name => "Programming", :id => nil})
    book2 = Books.new({:name => "Programming", :id => nil})
      expect(book1).to(eq(book2))
    end
  end

  describe(".find") do
    it("returns a book by its ID") do
      test_book = Books.new({:name => "Programming", :id => nil})
      test_book.save()
      test_book2 = Books.new({:name => "tffgdxgdx", :id => nil})
      test_book2.save()
      expect(Books.find(test_book2.id())).to(eq(test_book2))
    end
  end

  describe("#patrons") do
    it("returns patron for that book") do
      test_book = Books.new({:name => "Programming", :id => nil})
      test_book.save()
      test_patron = Patrons.new({:name => "Bob", :id => test_book.id()})
      test_patron.save()
      test_patron2 = Patrons.new({:name => "Ruby", :id => test_book.id()})
      test_patron2.save()
      expect(test_book.patrons()).to(eq([test_patron, test_patron2]))
    end
  end

  describe("#update") do
    it("lets you update book from the database") do
      book = Books.new({:name => "Programming", :id => nil})
      book.save()
      book.update({:name => "Programming"})
      expect(book.name()).to(eq("Programming"))
    end
  end

  describe("#delete") do
    it("lets you delete a book from the database") do
      book = Books.new({:name => "Programming", :id => nil})
      book.save()
      book2 = Books.new({:name => "vefvefv", :id => nil})
      book2.save()
      book.find()
      book.delete()
      expect(Books.all()).to(eq([book2]))
    end
  end

  describe("#update") do
    it("lets you add a patron to a book") do
      book = Books.new({:name => "Programming", :id => nil})
      book.save()
      patron1= Patrons.new({:name => "George Clooney", :id => nil})
      patron1.save()
      patron2 = Patrons.new({:name => "Brad Pitt", :id => nil})
      patron2.save()
      book.update({:patrons_ids => [patron1.id(), patron2.id()]})
      expect(book.patrons()).to(eq([patron1, patron2]))
    end
  end

  describe("#patrons") do
    it("returns all of the patrons for a book") do
      book = Books.new({:name => "Programming", :id => nil})
      book.save()
      patron1 = Patrons.new({:name => "George Clooney", :id => nil})
      patron1.save()
      patron2= Patrons.new({:name => "Brad Pitt", :id => nil})
      patron2.save()
      book.update({:patrons_ids => [patron1.id(), patron2.id()]})
      expect(book.patrons()).to(eq([patron1, patron2]))
    end
  end
end
