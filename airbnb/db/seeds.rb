# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }, { name: 'Chennai' }, { name: 'Newyork'}])

Home.create([{home_type: 'Apartment'}, { home_type: 'House'}, {home_type: 'Bed & Breakfast'}])

Room.create([{room_type: 'Entire home'}, { room_type: 'Shared room'}, { room_type: 'Private room'}])


