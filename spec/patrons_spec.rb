require("spec_helper")

describe(Patrons) do
  describe("#==") do
    it("is the same patron if it has the same name") do
      patron1 = Patrons.new({:name => "Bob", :id => "id"})
      patron2 = Patrons.new({:name => "Bob", :id => "id"})
      expect(patron1).to(eq(patron2))
    end
  end

  describe(".all") do
    it("is empty at first") do
      expect(Patrons.all()).to(eq([]))
    end
  end

  describe("#update") do
    it("lets you update patrons in the database") do
      patron = Patrons.new({:name => "George Clooney", :id => nil})
      patron.save()
      patron.update({:name => "Brad Pitt"})
      expect(patron.name()).to(eq("Brad Pitt"))
    end
  end

  describe("#delete") do
    it("lets you delete a patron from the database") do
      patron = Patrons.new({:name => "George Clooney", :id => nil})
      patron.save()
      patron2 = Patrons.new({:name => "Brad Pitt", :id => nil})
      patron2.save()
      patron.delete()
      expect(Patrons.all()).to(eq([patron2]))
    end
  end

  describe("#update") do
    it("lets you add a book to a patron") do
      book = Books.new({:name => "Programming", :id => nil})
      book.save()
      patron = Patrons.new({:name => "George Clooney", :id => nil})
      patron.save()
      patron.update({:book_ids => [book.id()]})
      expect(patron.books()).to(eq([book]))
    end
  end

  describe("#books") do
    it("returns all of the books a particular patron has rented") do
      book= Books.new(:name => "Programming", :id => nil)
      book.save()
      book2 = Books.new(:name => "fwdfwdc", :id => nil)
      book2.save()
      patron =Patrons.new(:name => "George Clooney", :id => nil)
      patron.save()
      patron.update(:book_id => [book.id()])
      patron.update(:book_id => [book2.id()])
      expect(patron.books()).to(eq([book, book2]))
    end
  end
end
