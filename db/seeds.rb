# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Initial Categories:
Website.create(title: 'Aucuparia', content: 'pending', menu_title: 'Thoughts')
Website.create(title: 'About Aucuparia', content: 'pending', menu_title: 'Beyond')

Category.create(name: 'Uncategorized Items', summary: '*These* items aren\'t really anywhere in particular. They\'re orphans, abandoned to the wilderness.')
Category.create(name: 'On Biology', summary: 'These are thoughts on Biology, the greatest of the sciences.', website: Website.first)
Category.create(name: 'On Books', summary: 'Thoughts on books, those amazing repositories of knowledge and thought.', website: Website.first)
Category.create(name: 'On Cooking', summary: 'Thoughts on cooking, and interesting recipes.', website: Website.first)
Category.create(name: 'Elsewhere', summary: 'What exists in other places.', website: Website.second)
Category.create(name: 'Otherwhen', summary: 'What exists in other times.', website: Website.second)
Category.create(name: 'Somniatus', summary: 'What exists within dream.', website: Website.second)
Category.create(name: 'Mindless', summary: 'What does not exist.', website: Website.second)

User.create(email: 'admin@aucuparia.net', password: 'ChangeMe!', password_confirmation: 'ChangeMe!', display_name: 'admin', admin: true)