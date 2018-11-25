Feature: Usuario
	As a usuario
	I want to ser capaz de estar registrado
	So that que eu posso fazer uso do sistema

	Scenario: Registrar usuario no sistema com sucesso
		Given Eu estou na pagina inicial
		When Eu clico para registrar
		And Eu estou na pagina de registro
		And Eu preencho o campo de nome com "Matheus"
		And Eu preencho o campo de email com "matheus@email.com"
		And Eu preencho o campo de senha com "senha muito dificil"
		And Eu preencho o campo de confirmacao de senha com "senha muito dificil"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu clico em registrar
		Then Eu devo ver que o meu registro foi bem sucedido

	#Scenarios do nome

	Scenario: Erro ao registrar usuario com nome menor que 5 caracteres
		Given Eu estou na pagina de registro
		When Eu preencho o campo de nome com "tem4"
		And Eu preencho o campo de email com "matheus@email.com"
		And Eu preencho o campo de senha com "senha muito dificil"
		And Eu preencho o campo de confirmacao de senha com "senha muito dificil"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu clico em registrar
		Then Eu devo ver que o meu nome tem que ser maior que 5 caracteres

	Scenario: Erro ao registrar usuario com nome em branco
		Given Eu estou na pagina de registro
		When Eu preencho o campo de email com "matheus@email.com"
		And Eu preencho o campo de senha com "senha muito dificil"
		And Eu preencho o campo de confirmacao de senha com "senha muito dificil"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu clico em registrar
		Then Eu devo ver que o meu nome não pode ser vazio

	Scenario: Erro ao registrar usuario com nome maior que 130 caracteres
		Given Eu estou na pagina de registro
		When Eu preencho o campo de nome com "Pedro de Alcântara João Carlos Leopoldo Salvador Bibiano Francisco Xavier de Paula Leocádio Miguel Gabriel Rafael Gonzaga agora complemento para mais de 130"
		And Eu preencho o campo de email com "matheus@email.com"
		And Eu preencho o campo de senha com "senha muito dificil"
		And Eu preencho o campo de confirmacao de senha com "senha muito dificil"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu clico em registrar
		Then Eu devo ver que o meu nome tem que ser menor que 130 caracteres

	Scenario: Erro ao registrar usuario com caracteres invalidos no nome
		Given Eu estou na pagina de registro
		When Eu preencho o campo de nome com "@matheus#"
		And Eu preencho o campo de email com "matheus@email.com"
		And Eu preencho o campo de senha com "senha muito dificil"
		And Eu preencho o campo de confirmacao de senha com "senha muito dificil"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu clico em registrar
		Then Eu devo ver que o meu nome não pode conter nenhum caracter especial

	#Scenarios do email

	Scenario: Erro ao registrar usuario com email em branco
		Given Eu estou na pagina de registro
		When Eu preencho o campo de nome com "Matheus"
		And Eu preencho o campo de senha com "senha muito dificil"
		And Eu preencho o campo de confirmacao de senha com "senha muito dificil"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu clico em registrar
		Then Eu devo ver que o meu email não pode estar em branco

	Scenario: Erro ao registrar usuario com email invalido
		Given Eu estou na pagina de registro
		When Eu preencho o campo de nome com "Matheus"
		And Eu preencho o campo de email com "matheus"
		And Eu preencho o campo de senha com "senha muito dificil"
		And Eu preencho o campo de confirmacao de senha com "senha muito dificil"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu clico em registrar
		Then Eu devo ver que o meu email é invalido

	Scenario: Erro ao registrar usuario com email já existente no sistema
		Given Eu estou na pagina de registro
		When Eu preencho o campo de nome com "Matheus"
		And Eu preencho o campo de email com "matheus@email.com"
		And Eu preencho o campo de senha com "senha muito dificil"
		And Eu preencho o campo de confirmacao de senha com "senha muito dificil"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu clico em registrar
		And Eu estou na pagina de registro
		And Eu preencho o campo de nome com "Outro Matheus"
		And Eu preencho o campo de email com "matheus@email.com"
		And Eu preencho o campo de senha com "senha muito dificil"
		And Eu preencho o campo de confirmacao de senha com "senha muito dificil"
		And Eu preencho o campo de descricao com "Ele não era ele e só"
		And Eu clico em registrar
		Then Eu devo ver que o meu email já foi cadastrado anteriormente

	#Scenarios da senha

	Scenario: Erro ao registrar usuario com senha e confirmacao em braco
		Given Eu estou na pagina de registro
		When Eu preencho o campo de nome com "Matheus"
		And Eu preencho o campo de email com "matheus"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu clico em registrar
		Then Eu devo ver que o campo senha e o campo confirmacao entá em branco

	Scenario: Erro ao registrar usuario com senha preenchida e confirmacao em branco
		Given Eu estou na pagina de registro
		When Eu preencho o campo de nome com "Matheus"
		And Eu preencho o campo de email com "matheus"
		And Eu preencho o campo de senha com "senha muito dificil"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu clico em registrar
		Then Eu devo ver que eu devo confirmar minha senha

	Scenario: Erro ao registrar usuario com senha menor que 6 caracteres e confirmacao igual
		Given Eu estou na pagina de registro
		When Eu preencho o campo de nome com "Matheus"
		And Eu preencho o campo de email com "matheus"
		And Eu preencho o campo de senha com "senha"
		And Eu preencho o campo de confirmacao de senha com "senha"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu clico em registrar
		Then Eu devo ver que a minha senha tem que ter pelos menos 6 caracteres

	Scenario: Erro ao registrar usuario com senha preenchida e confirmacao diferente da senha
		Given Eu estou na pagina de registro
		When Eu preencho o campo de nome com "Matheus"
		And Eu preencho o campo de email com "matheus"
		And Eu preencho o campo de senha com "senha1"
		And Eu preencho o campo de confirmacao de senha com "senha2"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu clico em registrar
		Then Eu devo ver que as minhas senhas não batem

	Scenario: Erro ao registrar usuario com senha menor que 6 caracteres e confirmacao diferente
		Given Eu estou na pagina de registro
		When Eu preencho o campo de nome com "Matheus"
		And Eu preencho o campo de email com "matheus"
		And Eu preencho o campo de senha com "s1"
		And Eu preencho o campo de confirmacao de senha com "s2"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu clico em registrar
		Then Eu devo ver que minhas senha não batem e não podem ter menos que 6 caracteres

	#Scenarios da foto

	Scenario: Registrar usuario com foto com sucesso
		Given Eu estou na pagina de registro
		When Eu preencho o campo de nome com "Matheus"
		And Eu preencho o campo de email com "matheus"
		And Eu preencho o campo de senha com "senha boa"
		And Eu preencho o campo de confirmacao de senha com "senha boa"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu faço o upload de uma foto para o perfil
		And Eu clico em registrar
		Then Eu devo ver que o meu registro foi bem sucedido

	Scenario: Erro ao registrar usuario com formato de foto invalido
		Given Eu estou na pagina de registro
		When Eu preencho o campo de nome com "Matheus"
		And Eu preencho o campo de email com "matheus"
		And Eu preencho o campo de senha com "senha boa"
		And Eu preencho o campo de confirmacao de senha com "senha boa"
		And Eu preencho o campo de descricao com "Eu sou eu e só"
		And Eu faço o upload de um arquivo que não seja imagem para o perfil
		And Eu clico em registrar
		Then Eu devo ver que o formato da imagem é invalido

	#Scenarios sobre edição de perfil
