# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(nome: "asdUm", email: "asd1@gmail.com", descricao: "minha descricao Um", password: "asdasd", password_confirmation: "asdasd", encrypted_password: "$2a$11$fr3nJyV3WIoHt2istPrqMOdbFM7NIatwfgLR9VAnCewbmgwr/m70S", created_at: "2018-12-19 21:03:56.919174", updated_at: "2018-12-19 21:03:56.919174")
# user_list.each do |nome, email, descricao, encrypted_password, created_at, updated_at|


############-APAGA AS COISA-#############
User.destroy_all
##################################



##########-ATRIBUTOS DAS COISA-############
user_list = [
	["asdUm", "asd1@gmail.com", "minha descricao Um", "asdasd", "asdasd", "$2a$11$fr3nJyV3WIoHt2istPrqMOdbFM7NIatwfgLR9VAnCewbmgwr/m70S", "2018-12-19 21:03:56.919174", "2018-12-19 21:03:56.919174"],
	["asdDois", "asd2@gmail.com", "minha descricao Dois", "asdasd", "asdasd", "$2a$11$fr3nJyV3WIoHt2istPrqMOdbFM7NIatwfgLR9VAnCewbmgwr/m70S", "2018-12-19 21:03:56.919174", "2018-12-19 21:03:56.919174"],
	["asdTres", "asd3@gmail.com", "minha descricao Tres", "asdasd", "asdasd", "$2a$11$fr3nJyV3WIoHt2istPrqMOdbFM7NIatwfgLR9VAnCewbmgwr/m70S", "2018-12-19 21:03:56.919174", "2018-12-19 21:03:56.919174"],
	["asdQuatro", "asd4@gmail.com", "minha descricao Quatro", "asdasd", "asdasd", "$2a$11$fr3nJyV3WIoHt2istPrqMOdbFM7NIatwfgLR9VAnCewbmgwr/m70S", "2018-12-19 21:03:56.919174", "2018-12-19 21:03:56.919174"],
	["asdCinco", "asd5@gmail.com", "minha descricao Cinco", "asdasd", "asdasd", "$2a$11$fr3nJyV3WIoHt2istPrqMOdbFM7NIatwfgLR9VAnCewbmgwr/m70S", "2018-12-19 21:03:56.919174", "2018-12-19 21:03:56.919174"]
]

##################################



##########-CRIA AS COISA-############
user_list.each do |nome, email, descricao, password, password_confirmation, encrypted_password, created_at, updated_at|
  User.create( nome: nome, email: email, descricao: descricao, password: password, password_confirmation: password_confirmation, encrypted_password: encrypted_password, created_at: created_at, updated_at: updated_at )
end

##################################



##########-Só printa e foi-##############
p "Criou?"
##################################
