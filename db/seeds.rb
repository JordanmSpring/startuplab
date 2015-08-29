# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Channel.create!(name: 'Social Media')
Channel.create!(name: 'Content Media')
Channel.create!(name: 'Other Media')
Channel.create!(name: 'Direct Marketing')
Channel.create!(name: 'Indirect Marketing')
Channel.create!(name: 'Business Development')
Channel.create!(name: 'Partnerships')
