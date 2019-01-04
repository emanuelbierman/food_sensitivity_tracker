# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: "emanuel", password: "password")
User.create(username: "user", password: "user")

month_day_year = Time.now.strftime("%m-%d-%y")
day = Day.create(month_day_year: month_day_year, user_id: 1, comments: "First day.")

food1 = Food.create(name: "pretzels", serving: 2)
food2 = Food.create(name: "chicken sausage", serving: 2)
# food3 = Food.create(name: "egg-fried rice", serving: 1)
# food4 = Food.create(name: "chickpea veggie burger", serving: 1)
# these last two objects are to confirm that I can create new objects with the same attributes, enabling me to group by name or description
# food5 = Food.create(name: "pretzels", serving: 1)
# food6 = Food.create(name: "pretzels", serving: 3)

symptom1 = Symptom.create(description: "acid reflux: throat burning", frequency: 1)
symptom2 = Symptom.create(description: "acid reflux: constricted breathing", frequency: 3)
# these last two objects are to confirm that I can create new objects with the same attributes, enabling me to group by name or description
# symptom5 = Symptom.create(description: "diarrhea: mealy", frequency: 1)
# symptom6 = Symptom.create(description: "diarrhea: mealy", frequency: 2)

day.foods << [food1, food2]
day.symptoms << [symptom1, symptom2]
day.save

# day.previous_day.foods << [food3, food5]
# day.previous_day.symptoms << [symptom3, symptom5]
# day.previous_day.save

# day.next_day.foods << [food4, food6]
# day.next_day.symptoms << [symptom4, symptom6]
# day.next_day.save
