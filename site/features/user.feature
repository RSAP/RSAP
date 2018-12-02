
@UserTeste
Feature: Usuario
	As a usuario
	I want to ser capaz de estar registrado
	So that que eu posso fazer uso do sistema

	Scenario: Registrar usuario no sistema com sucesso
		Given eu estou na pagina inicial
		When eu clico para registrar
		And eu estou na pagina de registro
		And eu preencho os campos de nome com "Matheus", email com "matheus@email.com", senha com "senha muito dificil", confirmacao de senha com "senha muito dificil", descricao com "Eu sou eu e so"
		And eu clico em registrar usuario
		Then eu devo ver que o meu registro foi bem sucedido

	#Scenarios do nome

	Scenario: Erro ao registrar usuario com nome menor que 5 caracteres
		Given eu estou na pagina de registro
		And eu preencho os campos de nome com "Yuri", email com "yuri@email.com", senha com "senha muito dificil", confirmacao de senha com "senha muito dificil", descricao com "Aopa"
		And eu clico em registrar usuario
		Then eu vejo a mensagem de erro "Nome deve ter pelo menos 5 caracteres"

	Scenario: Erro ao registrar usuario com nome em branco
		Given eu estou na pagina de registro
		And eu preencho os campos de email com "matheus@email.com", senha com "senha muito dificil", confirmacao de senha com "senha muito dificil", descricao com "Aopa"
		And eu clico em registrar usuario
		Then eu vejo a mensagem de erro "Nome em branco"

	Scenario: Erro ao registrar usuario com nome maior que 130 caracteres
		Given eu estou na pagina de registro
		When eu preencho os campos de nome com "Pedro de Alcantara Joao Carlos Leopoldo Salvador Bibiano Francisco Xavier de Paula Leocadio Miguel Gabriel Rafael Gonzaga agora complemento para mais de 130", email com "matheus@email.com", senha com "senha muito dificil", confirmacao de senha com "senha muito dificil", descricao com "Eu sou eu e so"
		And eu clico em registrar usuario
		Then eu vejo a mensagem de erro "Nome deve ter no maximo 130 caracteres"

	Scenario: Erro ao registrar usuario com caracteres invalidos no nome
		Given eu estou na pagina de registro
		When eu preencho os campos de nome com "@Matheus#", email com "matheus@email.com", senha com "senha muito dificil", confirmacao de senha com "senha muito dificil", descricao com "Eu sou eu e so"
		And eu clico em registrar usuario
		Then eu vejo a mensagem de erro "Nome nao pode conter caracteres especiais"

	#Scenarios do email

	Scenario: Erro ao registrar usuario com email em branco
		Given eu estou na pagina de registro
		When eu preencho os campos de nome com "Matheus", senha com "senha muito dificil", confirmacao de senha com "senha muito dificil", descricao com "Eu sou eu e so"
		And eu clico em registrar usuario
		Then eu vejo a mensagem de erro "Email em branco"

	Scenario: Erro ao registrar usuario com email invalido
		Given eu estou na pagina de registro
		When eu preencho os campos de nome com "Matheus", email com "matheus", senha com "senha muito dificil", confirmacao de senha com "senha muito dificil", descricao com "Eu sou eu e so"
		And eu clico em registrar usuario
		Then eu vejo a mensagem de erro "Email invalido"

	Scenario: Erro ao registrar usuario com email ja existente no sistema
		Given Exite um usuario registrado com o email "matheus@email.com"
		When eu estou na pagina de registro
		And eu preencho os campos de nome com "Outro Matheus", email com "matheus@email.com", senha com "senha muito dificil", confirmacao de senha com "senha muito dificil", descricao com "Ele nao era ele e so"
		And eu clico em registrar usuario
		Then eu vejo a mensagem de erro "Email ja cadastrado"

	#Scenarios da senha

	Scenario: Erro ao registrar usuario com senha e confirmacao em braco
		Given eu estou na pagina de registro
		When eu preencho os campos de nome com "Matheus", email com "matheus@email.com", descricao com "Eu sou eu e so"
		And eu clico em registrar usuario
		Then eu vejo a mensagem de erro "Senha em branco"
		And eu vejo a mensagem de erro "Confirmacao em branco"

	Scenario: Erro ao registrar usuario com senha preenchida e confirmacao em branco
		Given eu estou na pagina de registro
		When eu preencho os campos de nome com "Matheus", email com "matheus@email.com", senha com "senha muito dificil", descricao com "Eu sou eu e so"
		And eu clico em registrar usuario
		Then eu vejo a mensagem de erro "Confirmacao em branco"

	Scenario: Erro ao registrar usuario com senha menor que 6 caracteres e confirmacao igual
		Given eu estou na pagina de registro
		When eu preencho os campos de nome com "Matheus", email com "matheus@email.com", senha com "senha", confirmacao de senha com "senha", descricao com "Eu sou eu e so"
		And eu clico em registrar usuario
		Then eu vejo a mensagem de erro "Senha deve conter pelo menos 6 caracteres"

	Scenario: Erro ao registrar usuario com senha preenchida e confirmacao diferente da senha
		Given eu estou na pagina de registro
		When eu preencho os campos de nome com "Matheus", email com "matheus@email.com", senha com "senha1", confirmacao de senha com "senha2", descricao com "Eu sou eu e so"
		And eu clico em registrar usuario
		Then eu vejo a mensagem de erro "Confirmacao nao bate com senha"

	Scenario: Erro ao registrar usuario com senha menor que 6 caracteres e confirmacao diferente
		Given eu estou na pagina de registro
		When eu preencho os campos de nome com "Matheus", email com "matheus@email.com", senha com "s1", confirmacao de senha com "s2", descricao com "Eu sou eu e so"
		And eu clico em registrar usuario
		Then eu vejo a mensagem de erro "Senha deve conter pelo menos 6 caracteres"
		And eu vejo a mensagem de erro "Confirmacao nao bate com senha"

	#Scenarios da foto

	Scenario: Registrar usuario com foto com sucesso
		Given eu estou na pagina de registro
		When eu preencho os campos de nome com "Matheus", email com "matheus@email.com", senha com "senha muito dificil", confirmacao de senha com "senha muito dificil", descricao com "Eu sou eu e so"
		And eu faco o upload de uma foto "foto.png" para o perfil
		And eu clico em registrar usuario
		Then eu devo ver que o meu registro foi bem sucedido

	Scenario: Erro ao registrar usuario com formato de foto invalido
		Given eu estou na pagina de registro
		When eu preencho os campos de nome com "Matheus", email com "matheus@email.com", senha com "senha muito dificil", confirmacao de senha com "senha muito dificil", descricao com "Eu sou eu e so"
		And eu faco o upload de um arquivo que nao seja imagem para o perfil
		And eu clico em registrar usuario
		Then eu vejo a mensagem de erro "Imagem invalida"

	#TODO: Scenarios sobre edicao de perfil
