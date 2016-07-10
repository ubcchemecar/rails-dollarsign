# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Record.delete_all
Record.create!( id: 1, item: 'first', description:'desc', price: 10.00, quantity: 5, supplier: 'digikey', link:'google.com', status: 1)
