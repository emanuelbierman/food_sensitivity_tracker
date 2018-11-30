# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

day = Day.new
user = User.create(username: "emanuel", password: "password")
food1 = Food.create(name: "gluten-free pretzels", serving: 2)
food2 = Food.create(name: "egg-fried rice", serving: 1)
food3 = Food.create(name: "chicken sausage", serving: 2)
symptom1 = Symptom.create(description: "diarrhea: mealy", frequency: 2)
symptom2 = Symptom.create(description: "diarrhea: wet", frequency: 2)
symptom3 = Symptom.create(description: "acid reflux: throat burning", frequency: 1)
day.user = user
day.foods << [food1, food2, food3]
day.symptoms << [symptom1, symptom2, symptom3]
day.save
