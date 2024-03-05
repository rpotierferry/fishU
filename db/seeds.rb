# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Plant.destroy_all
Fish.destroy_all
Tank.destroy_all
User.destroy_all

user = User.new(email: 'email@email.com', password: "123456", currency: 0)
user.save

tank = Tank.new(liters: 5, nitrate: 0, has_lamp: false, user: user)
tank.save

Plant.create(tank: tank, plant_type: 'nana', life_expectancy: 2)

Fish.create(tank: tank, name: "lili", sick: false, alive: true, species: "goldfish", size: 1)

Fish.create(tank: tank, name:"Lila")

puts "plante crée"
