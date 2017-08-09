# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


admin = Rol.create name: 'Admin', code: 1
user = Rol.create name: 'User', code: 2
watcher = Rol.create name: 'Watcher', code: 3

SkillsLevel.create name: 'junior', code: 0
SkillsLevel.create name: 'regular', code: 1
SkillsLevel.create name: 'master', code: 2


Country.create name: 'egipto'
Country.create name: 'usa'
Country.create name: 'colombia'
Country.create name: 'venezuela'

City.create country_id: 1,name: 'el cairo'
City.create country_id: 2,name: 'new york'
City.create country_id: 3,name: 'cali'
City.create country_id: 4,name: 'maracaibo'

User.create email: 'prueba@garonz.com', password: '12345', rol_id: admin.id, name: 'jorge', lastname: 'hernandez'
