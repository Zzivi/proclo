# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Ingredients
99.times do |n|
  name  = Faker::Lorem.word + "#{n}"
  description = Faker::Lorem.sentence
  Ingredient.create!(name:  name, description: description)
end

# Recipes
50.times do |n|
  name  = Faker::Lorem.word + "#{n}"
  description = Faker::Lorem.sentence
  Recipe.create!(name:  name, description: description, time: n)
end

# IngredientQuantities
recipes = Recipe.all
offset = rand(0..Ingredient.count-5)
5.times do |n|
  recipes.each { |recipe| recipe.ingredient_quantities.create!(quantity: Faker::Number.number(2), ingredient_id: Ingredient.offset(offset + n).first.id) }
end

