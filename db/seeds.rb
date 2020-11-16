# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
Cocktail.destroy_all
Dose.destroy_all
Ingredient.destroy_all

require 'json'
require 'open-uri'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
list = open(url).read
result = JSON.parse(list)

result["drinks"].each do |row|
  ingredient = Ingredient.new(name: row['strIngredient1'])
  ingredient.save!
  end

url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'
list = open(url).read
result = JSON.parse(list)

alcohol = []
result["drinks"].each do |row|
  alcohol << row['idDrink']
end

alcohol.each do |id|
  url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{id}"
list = open(url).read
result = JSON.parse(list)
  cocktail = Cocktail.new(name: result['drinks'][0]['strDrink'])
  cocktail.save!
end

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
