# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
  User has_many Days
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
  Day belongs_to User
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
  Users have many Foods through Days
  Users have many Symptoms through Days
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
  Foods habtm Days
  Symptoms habtm Days
  Foods have many Symptoms through Days
  Symptoms have many Foods through Days
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
  Day.comments
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
  Day, User, Food, Symptom
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature:  
   Food.foods_by_days_count
   URL: /users/:user_id/foods
   method defined: food.rb:12
   method called: foods_controller.rb:9
- [x] Include signup (how e.g. Devise)
- [x] Include signup (how e.g. Devise)
- [x] Include login (how e.g. Devise)
- [x] Include logout (how e.g. Devise)
- [ ] Include third party signup/login (how e.g. Devise/OmniAuth)
- [x] Include nested resource show or index
  URL: /users/:user_id/foods
  URL: /users/:user_id/foods/:food_id
  URL: /users/:user_id/symptoms/:symptom_id
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
  URL: "/"
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
  URL: "/"

Confirm:
- [X] The application is pretty DRY
- [X] Limited logic in controllers
- [X] Views use helper methods if appropriate
- [X] Views use partials if appropriate
