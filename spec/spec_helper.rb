require("rspec")
require("pg")
require("patrons")
require("books")
require("pry")

DB = PG.connect({:dbname => "library_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patrons *;")
    DB.exec("DELETE FROM books *;")
  
  end
end
