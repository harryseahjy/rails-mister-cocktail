# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

# list = JSON.parse(open('https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list').read)['drinks']

# list.each do |l|
#     ingredient = Ingredient.new(name: l.values[0])
#     ingredient.save!
# end

9.times do
  data = JSON.parse(open('https://www.thecocktaildb.com/api/json/v1/1/random.php').read)['drinks'][0]
  cocktail = Cocktail.create(name: data['strDrink'].downcase)

  cocktail.photo.attach(io: open(data['strDrinkThumb']), filename: "#{data['strDrink']}.jpg", content_type: 'image/png')
  ingredients = []
  ingredient_names = data.select { |key, _| key.to_s.match(/strIngredient/) }.values.compact
  ingredient_names.each do |name|
    result = Ingredient.find_by name: name.downcase
    result = Ingredient.create!(name: name.downcase) if result.nil?
    ingredients << result
  end
  amounts = data.select { |key, _| key.to_s.match(/strMeasure/) }.values.compact
  doses = amounts.zip(ingredients)
  doses.each { |dose| Dose.create(cocktail: cocktail, ingredient: dose[1], description: dose[0]) }
end
