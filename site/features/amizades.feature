@AmizadesTeste
Feature: Amizades
	As a usuario
	I want to ser capaz de encontrar o perfil de outros usuarios para gerar relacionamentos e ver informacoes
	So that que eu posso estar em uma iteracao social

	Scenario: Encontrar uma pessoa na rede
		Given existe um usuario registrado com nome "Matheus"
		And eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		When eu clico para buscar um usuario
		And eu preencho o campo de nome com "Matheus"
		And eu clico em buscar
		Then eu vejo que existe um usuario chamado "Matheus"

	Scenario: Visualizar perfil de uma pessoa na rede
		Given existe um usuario registrado com nome "Matheus"
	  	And eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		When eu clico para buscar um usuario
		And eu preencho o campo de nome com "Matheus"
		And eu clico em buscar
		And eu vejo que existe um usuario chamado "Matheus"
		And eu clico para ver o perfil do usuario "Matheus"
		Then Eu vejo a pagina do perfil do usuario "Matheus"

	Scenario: Perfil deve conter o email do usuario
		Given existe um usuario registrado com nome "Matheus"
	  	And eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		When eu clico para buscar um usuario
		And eu preencho o campo de nome com "Matheus"
		And eu clico em buscar
		And eu vejo que existe um usuario chamado "Matheus"
		And eu clico para ver o perfil do usuario "Matheus"
		Then eu vejo que o perfil contem o email "matheus@email.com"

	Scenario: Enviar solicitacao de amizade
		Given existe um usuario registrado com nome "Matheus"
	  	And eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		When eu clico para buscar um usuario
		And eu preencho o campo de nome com "Matheus"
		And eu clico em buscar
		And eu vejo que existe um usuario chamado "Matheus"
		And eu clico para ver o perfil do usuario "Matheus"
		And eu solicito amizade ao usuario "Matheus"
		Then eu vejo que minha solicitacao foi enviada

	Scenario: Erro ao solicitar um usuario inexistente
	  	Given eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		When eu envio uma solicitacao para um usuario inexistente
		Then eu vejo a mensagem de erro "Usuario inexistente"

	Scenario: Erro ao solicitar amizade a mim mesmo
	  	Given eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		And eu estou no meu proprio perfil
		When eu solicito amizade a mim mesmo
		Then eu vejo a mensagem de erro "Voce nao pode solicitar amizade a si mesmo"

	Scenario: Erro ao solicitar amizade de usuario que ja eh amigo
		Given existe um usuario registrado com nome "Matheus"
	  	And eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		And eu estou na pagina de perfil do usuario "Matheus"
		When eu vejo que o usuario "Matheus" ja eh meu amigo
		And eu envio uma solicitacao de amizade para o usuario "Matheus"
		Then eu vejo a mensagem de erro "Voce nao pode solicitar amizade de alguem que ja eh seu amigo"

	Scenario: Erro ao solicitar amizade novamente enquanto uma solicitacao ja esta pendente
		Given existe um usuario registrado com nome "Matheus"
	  	And eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		And eu estou na pagina de perfil do usuario "Matheus"
		When eu solicito amizade ao usuario "Matheus"
		And eu solicito amizade ao usuario "Matheus"
		Then eu vejo a mensagem de erro "Voce nao pode solicitar amizade enquanto houver uma solitacao pendente"

	Scenario: Aceitar solicitacao de amizade
		Given existe um usuario registrado com nome "Matheus"
		And o usuario com nome "Matheus" enviou uma solicitacao de amizade para mim
	  	And eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		And eu vejo minha lista de amizades
		When eu vejo que o usuario "Matheus" nao esta na lista de amizades
		And eu estou na minha lista de solicitacoes de amizade para mim
		And eu vejo que o usuario "Matheus" esta na lista de solicitacoes de amizade
		And eu aceito a solicitacao do usuario "Matheus"
		And eu vejo minha lista de amizades
		Then eu vejo que o usuario "Matheus" esta na lista de amizades

	Scenario: Recusar solicitacao de amizade
		Given existe um usuario registrado com nome "Matheus"
		And o usuario com nome "Matheus" enviou uma solicitacao de amizade para mim
	  	And eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		And eu estou na minha lista de solicitacoes de amizade para mim
		When eu vejo que o usuario "Matheus" esta na lista de solicitacoes de amizade para mim
		And eu recuso a solicitacao do usuario "Matheus"
		Then eu vejo que o usuario "Matheus" nao esta na lista de solicitacoes de amizade para mim

	Scenario: Desfazer amizade
		Given existe um usuario registrado com nome "Matheus"
		And eu e o usuario "Matheus" somos amigos na rede social
	  	Given eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		And eu vejo minha lista de amizades
		When eu clico para visualizar o perfil do usuario "Matheus"
		And eu clico para desfazer amizade com o usuario "Matheus"
		And eu vejo minha lista de amizades
		Then eu vejo que o usuario "Matheus" nao esta mais na minha lista de amizades

	Scenario: Recusar uma amizade inexistente
		Given eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		When eu tento recusar uma amizade inexistente
		Then eu vejo a mensagem de erro "Essa amizade não existe!"

	Scenario: Aceitar uma amizade inexistente
		Given eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		When eu tento aceitar uma amizade inexistente
		Then eu vejo a mensagem de erro "Essa amizade não existe!"

	Scenario: Recusar pedido de amizade feito entre outros usuarios
		Given o usuario "Matheus" com email "matheus@email.com" e senha "123456" existe
		And o usuario "Baltazar" com email "baltazar@email.com" e senha "123456" existe
		And o usuario "Baltazar" fez um pedido de amizade para o usuario "Matheus"
		And eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		When eu tento recusar o pedido de amizade feito por "Matheus" para "Baltazar"
		Then eu vejo a mensagem de erro "Você não tem permissão para fazer isso!"

	Scenario: Aceitar pedido de amizade feito entre outros usuarios
		Given o usuario "Matheus" com email "matheus@email.com" e senha "123456" existe
		And o usuario "Baltazar" com email "baltazar@email.com" e senha "123456" existe
		And o usuario "Baltazar" fez um pedido de amizade para o usuario "Matheus"
		And eu estou logado no meu perfil da rede social com o email "carlosantonio@o-nucleo.com" e senha "rails123456"
		When eu tento aceitar o pedido de amizade feito por "Matheus" para "Baltazar"
		Then eu vejo a mensagem de erro "Você não tem permissão para fazer isso!"
