# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(
  name: 'Marcelo Antônio Fernandes Guimarães',
  cpf: '113.721.706-50',
  email: 'mafguiamaraes@sga.pucminas.br',
  birth_date: '25/02/1999',
  password: 'computador',
  password_confirmation: 'computador',
)
License.create!(
  cnh_type: 1,
  first_cnh_date: '19/03/2018',
  cnh_number: '07021125933',
  user_id: user.id
)

Vehicle.create!(
  plate: '23432432',
  chassi: '23432432',
  renavam: '324324',
  user_id: user.id,
  color: 'Verde',
  model: 'Pálio'
)
