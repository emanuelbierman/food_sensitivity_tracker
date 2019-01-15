# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(username: "sample user", password: "password")
date = Time.now.strftime("%d")
day = Day.create(date: date, user_id: user.id)
food = Food.create(name: "pizza")
days_food = DaysFood.create(day_id: day.id, food_id: food.id, serving: 1, comments: "peer-pressured into eating at birthday party")
food2 = Food.create(name: "ice cream")
days_food2 = DaysFood.create(day_id: day.id, food_id: food2.id, serving: 2)
symptom = Symptom.create(description: "mucus")
days_symptom = DaysSymptom.create(day_id: day.id, symptom_id: symptom.id, frequency: 1, comments: "mucus after cheese")
food.save
food2.save
day.save
days_food.save
symptom.save
days_symptom.save

# food1 = Food.create(name: "pretzels", serving: 2)
# food2 = Food.create(name: "chicken sausage", serving: 2)
# food3 = Food.create(name: "egg-fried rice", serving: 1)
# food4 = Food.create(name: "chickpea veggie burger", serving: 1)
# these last two objects are to confirm that I can create new objects with the same attributes, enabling me to group by name or description
# food5 = Food.create(name: "pretzels", serving: 1)
# food6 = Food.create(name: "pretzels", serving: 3)

# symptom1 = Symptom.create(description: "acid reflux: throat burning", frequency: 1)
# symptom2 = Symptom.create(description: "acid reflux: constricted breathing", frequency: 3)
# these last two objects are to confirm that I can create new objects with the same attributes, enabling me to group by name or description
# symptom5 = Symptom.create(description: "diarrhea: mealy", frequency: 1)
# symptom6 = Symptom.create(description: "diarrhea: mealy", frequency: 2)

# day.foods << [food1, food2]
# day.symptoms << [symptom1, symptom2]
# day.save

# day.previous_day.foods << [food3, food5]
# day.previous_day.symptoms << [symptom3, symptom5]
# day.previous_day.save

# day.next_day.foods << [food4, food6]
# day.next_day.symptoms << [symptom4, symptom6]
# day.next_day.save
