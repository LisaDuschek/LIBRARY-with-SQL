require('sinatra')
require('sinatra/reloader')
require('./lib/books')
require('./lib/patrons')
also_reload('lib/**/*.rb')
require("pg")
require("pry")

DB = PG.connect({:dbname => "library"})

get("/") do
  @books = Books.all()

  erb(:index)
end

get('/book') do
  @books = Books.all()

  erb(:book)
end

post("/book") do
  name = params.fetch("name")
  book = Books.new({:name => name, :id => nil})
  book.save()
  @books = Books.all()
  erb(:book)
end



get('/patron') do
  @patrons = Patrons.all()
  erb(:patron)
end

post("/patron") do
  name = params.fetch("name")
  patron = Patrons.new({:name => name, :id => nil})
  patron.save()
  @patrons = Patrons.all()
  erb(:patron)
end

get("/patrons/:id") do
  @patron= Patrons.find(params.fetch("id").to_i())
  @books = Books.all()
  erb(:patron_info)
end

get("/books/:id") do
  @book = Books.find(params.fetch("id").to_i())
  @patrons = Patrons.all()
  erb(:book_info)
end

patch("/patron/:id") do
  patron_id = params.fetch("id").to_i()
  @patron = Patrons.find(patron_id)
  book_ids = params.fetch("book_ids")
  @patron.update({:book_ids => book_ids})
  @books = Books.all()
  erb(:patron_info)
end

patch("/books/:id") do
  book_id = params.fetch("id").to_i()
  @book = Books.find(book_id)
  patron_ids = params.fetch("patron_ids")
  @book.update({:patron_ids => patron_ids})
  @patrons = Patrons.all()
  erb(:book_info)
end
