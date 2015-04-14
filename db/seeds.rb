# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Main Pages:
StaticPage.create(title: 'Aucuparia', content: '**Aucuparia** - *n*. A deciduous tree in the <em>Rosaceae</em> family, often called the rowan or mountain-ash, more properly referred to by its full binomial name, *Sorbus aucuparia*. *Lit.* "birdcatcher", from <em>avis</em> (latin, "bird") and *capere* (latin, present infinitive form of *capio*, "to capture"), named as such because of the use of its fruit as bait for fowling.')
StaticPage.create(title: 'About Aucuparia', content: '**Aucuparia.net** - *n*. An experiment of sorts.\r\n\r\nThis website is running on Ruby on Rails, proxied through NGINX. Some portions of it live in an SQLite database; some portions do not. Ultimately, it lives on a rather small NAS sitting near an ocean, by way of a bay. It is designed to be fully functional on both desktop and mobile browsers, and to look much the same on both.\r\n\r\nIn addition to a tendency to try to explain words by defining them, this website contains thoughts on a variety of subjects, most notably the most valuable scientific discipline (Biology, clearly), books (particularly genre fiction), and cooking (mainly recipes for baked goods).\r\n\r\nIt also contains a variety of other things. The entire thing exists in varying states of completion, so do not be surprised by any lack of functionality, or any unexpected functionalities. It is an experiment, after all.')

# Menu Headings
Menu.create(title: 'Thoughts', visible: true)
Menu.create(title: 'Beyond', visible: true)
Menu.create(title: 'None', visible: false)

# Categories
Category.create(name: 'Uncategorized Items', summary: '*These* items aren\'t really anywhere in particular. They\'re orphans, abandoned to the wilderness.', menu_id: Menu.third.id)
Category.create(name: 'On Biology', summary: 'These are thoughts on Biology, the greatest of the sciences.', menu_id: Menu.first.id)
Category.create(name: 'On Books', summary: 'Thoughts on books, those amazing repositories of knowledge and thought.', menu_id: Menu.first.id)
Category.create(name: 'On Cooking', summary: 'Thoughts on cooking, and interesting recipes.', menu_id: Menu.first.id)
Category.create(name: 'Elsewhere', summary: 'What exists in other places.', menu_id: Menu.second.id)
Category.create(name: 'Otherwhen', summary: 'What exists in other times.', menu_id: Menu.second.id)
Category.create(name: 'Somniatus', summary: 'What exists within dream.', menu_id: Menu.second.id)
Category.create(name: 'Mindless', summary: 'What does not exist.', menu_id: Menu.second.id)

Core.create(twitter: 'S_aucuparia', github: 'Sorbus/aucuparia', email: 'rowan@aucuparia.net', show_icons: true, show_login: true)

Role.create(name: 'SuperAdmin')
Role.create(name: 'Admin')
Role.create(name: 'Moderator')
Role.create(name: 'Editor')
Role.create(name: 'Author')
Role.create(name: 'Commenter')