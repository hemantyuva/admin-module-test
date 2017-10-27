# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.destroy_all
Admin.destroy_all

name = ["Administrator","School manager","Promotions manager","School Assistant","Teachers"]
name.each do |f|
	Role.find_or_create_by(name: f)
end
Admin.find_or_create_by(name: 'admin',email:"admin@example.com", role_id: Role.first.id ,password: "password")
Admin.find_or_create_by(name: 'admin',email:"school-ma@example.com", role_id: Role.first.id ,password: "password")
Admin.find_or_create_by(name: 'admin',email:"promotion-ma@example.com", role_id: Role.second.id ,password: "password")
Admin.find_or_create_by(name: 'admin',email:"school-assis@example.com", role_id: Role.third.id ,password: "password")
Admin.find_or_create_by(name: 'admin',email:"teacher@example.com", role_id: Role.fourth.id ,password: "password")