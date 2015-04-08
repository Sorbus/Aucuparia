# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Main Pages:
Core.create(title: 'Aucuparia', content: '**Aucuparia** - *n*. A deciduous tree in the <em>Rosaceae</em> family, often called the rowan or mountain-ash, more properly referred to by its full binomial name, *Sorbus aucuparia*. *Lit.* "birdcatcher", from <em>avis</em> (latin, "bird") and *capere* (latin, present infinitive form of *capio*, "to capture"), named as such because of the use of its fruit as bait for fowling.')
Core.create(title: 'About Aucuparia', content: '**Aucuparia.net** - *n*. An experiment of sorts.\r\n\r\nThis website is running on Ruby on Rails, proxied through NGINX. Some portions of it live in an SQLite database; some portions do not. Ultimately, it lives on a rather small NAS sitting near an ocean, by way of a bay. It is designed to be fully functional on both desktop and mobile browsers, and to look much the same on both.\r\n\r\nIn addition to a tendency to try to explain words by defining them, this website contains thoughts on a variety of subjects, most notably the most valuable scientific discipline (Biology, clearly), books (particularly genre fiction), and cooking (mainly recipes for baked goods).\r\n\r\nIt also contains a variety of other things. The entire thing exists in varying states of completion, so do not be surprised by any lack of functionality, or any unexpected functionalities. It is an experiment, after all.')

Menu.create(title: 'Thoughts', visible: true)
Menu.create(title: 'Beyond', visible: true)
Menu.create(title: 'None', visible: false)


Category.create(name: 'Uncategorized Items', summary: '*These* items aren\'t really anywhere in particular. They\'re orphans, abandoned to the wilderness.' menu: Menu.third)
Category.create(name: 'On Biology', summary: 'These are thoughts on Biology, the greatest of the sciences.', menu: Menu.first)
Category.create(name: 'On Books', summary: 'Thoughts on books, those amazing repositories of knowledge and thought.', menu: Menu.first)
Category.create(name: 'On Cooking', summary: 'Thoughts on cooking, and interesting recipes.', menu: Menu.first)
Category.create(name: 'Elsewhere', summary: 'What exists in other places.', menu: Menu.second)
Category.create(name: 'Otherwhen', summary: 'What exists in other times.', menu: Menu.second)
Category.create(name: 'Somniatus', summary: 'What exists within dream.', menu: Menu.second)
Category.create(name: 'Mindless', summary: 'What does not exist.', menu: Menu.second)

RegistrationToken.create(token: 'superuser', is_superuser: true)