# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(username: "emanuel", password: "password")
user2 = User.create(username: "laura", password: "mollydog")
user = User.create(username: "user", password: "user")

day1 = Day.create(user_id: 1, comments: "Accidentally ate gluten.")
previous_day = Day.create(user_id: 2, comments: "Accidentally ate onion powder.")
previous_day.month_day_year = 1.day.ago.strftime("%m-%d-%y")
previous_day.day_of_week = 1.day.ago.strftime("%A")

food1 = Food.create(name: "pretzels", serving: 2)
food2 = Food.create(name: "chicken sausage", serving: 2)
food3 = Food.create(name: "egg-fried rice", serving: 1)
food4 = Food.create(name: "chickpea veggie burger", serving: 1)

symptom1 = Symptom.create(description: "diarrhea: mealy", frequency: 2)
symptom2 = Symptom.create(description: "diarrhea: wet", frequency: 2)
symptom3 = Symptom.create(description: "acid reflux: throat burning", frequency: 1)
symptom4 = Symptom.create(description: "acid reflux: constricted breathing", frequency: 3)

day1.user = user1
day1.foods << [food1, food2]
day1.symptoms << [symptom1, symptom2]
day1.save

day2.user = user1
day2.foods << [food3, food4]
day2.symptoms << [symptom3, symptom4]
day2.save

# I should be able to call:
# user.days
# user.foods
# user.symptoms
#
# day.foods
# day.symptoms
# day.user
#
# food.symptoms
# food.days
#
# symptom.foods
# symptom.days
