Feature: Amizades
	As a usuario
	I want to ser capaz de encontrar o perfil de outros usuarios para gerar relacionamentos e ver informacoes
	So that que eu posso estar em uma iteracao social

	Scenario: Encontrar uma pessoa na rede
		Given existe um usuario registrado com nome "Matheus"
		When eu estou na pagina de feed
		And eu clico para buscar um usuario
		And eu preencho o campo de nome com "Matheus"
		And eu clico em buscar
		Then eu devo ver que existe um usuario chamado "Matheus"

	Scenario: Visualizar perfil de uma pessoa na rede
		Given existe um usuario registrado com nome "Matheus"
		And eu estou na pagina de feed
		When eu clico para buscar um usuario
		And eu preencho o campo de nome com "Matheus"
		And eu clico em buscar
		And eu vejo que existe um usuario chamado "Matheus"
		And eu clico para ver o perfil do usuario "Matheus"
		Then Eu vejo a pagina do perfil do usuario "Matheus"

	Scenario: Perfil deve conter o email do usuario
		Given existe um usuario registrado com nome "Matheus"
		When eu procuro o usuario "Matheus"
		And eu clico para ver o perfil do usuario "Matheus"
		Then eu vejo que o perfil contem o email "matheus@email.com"

	Scenario: Enviar solicitacao de amizade
		Given existe um usuario registrado com nome "Matheus"
		When eu procuro o usuario "Matheus"
		And eu solicito a amizade do usuario "Matheus"
		Then eu vejo que minha solicitacao foi enviada

	Scenario: Erro ao solicitar um usuario inexistente
		Given eu estou na pagina de perfil do usuario "Matheus"
		When eu envio uma solicitacao para um usuario inexistente
		Then eu vejo que o usuario solicitado nao existe

	Scenario: Erro ao solicitar amizade a mim mesmo
		Given eu estou no meu proprio perfil
		When eu solicito amizade a mim mesmo
		Then eu vejo que eu nao posso solicitar amizade a mim mesmo

	Scenario: Erro ao cancelar solicitacao de amizade a mim mesmo
		Given eu estou no meu proprio perfil
		When eu cancelo a solicitacao de amizade a mim mesmo
		Then eu vejo que eu nao posso cancelar uma solicitacao enviada a mim mesmo

	Scenario: Erro ao solicitar amizade de usuario que ja eh amigo
		Given eu estou na pagina de perfil do usuario "Matheus"
		When eu vejo que o usuario "Matheus" ja eh meu amigo
		And eu envio uma solicitacao de amizade para o usuario "Matheus"
		Then eu vejo que ja somos amigos e por isso nao foi solicitada a amizade

	Scenario: Erro ao solicitar amizade novamente enquanto uma solicitacao ja esta pendente
		Given eu estou na pagina de perfil do usuario "Matheus"
		When eu solicito a amizade do usuario "Matheus"
		And eu estou na pagina de perfil do usuario "Matheus"
		And eu solicito a amizade do usuario "Matheus"
		Then eu vejo que ja existe uma solicitacao pendente e por isso nao eh solicitado novamente

	Scenario: Erro ao cancelar solicitacao de um usuario inexistente
		Given eu vejo minha lista de amizades
 		When eu cancelo uma solicitacao para um usuario inexistente
		Then eu vejo que nao existe uma solicitacao para um usuario que nao existe

	Scenario: Aceitar solicitacao de amizade
		Given eu vejo minha lista de amizades
		When eu vejo que o usuario "Matheus" nao esta na lista de amizades
		And eu estou na minha lista de solicitacoes de amizade para mim
		And eu vejo que o usuario "Matheus" esta na lista de solicitacoes de amizade
		And eu aceito a solicitacao do usuario "Matheus"
		And eu vejo minha lista de amizades
		Then eu vejo que o usuario "Matheus" esta na lista de amizades

	Scenario: Recusar solicitacao de amizade
		Given eu estou na minha lista de solicitacoes de amizade para mim
		When eu vejo que o usuario "Matheus" esta na lista de solicitacoes de amizade para mim
		And eu recuso a solicitacao do usuario "Matheus"
		Then eu vejo que o usuario "Matheus" nao esta na lista de solicitacoes de amizade para mim

	Scenario: Erro ao aceitar solicitacao de amizade de usuario inexistente
		Given eu estou na minha lista de solicitacoes de amizade para mim
		When eu aceito um pedido de amizade feito por um usuario que nao existe
		Then eu vejo que nao posso ser solicitado por um usuario que nao existe

	Scenario: Erro ao aceitar solicitacao de amizade de usuario que nao solicitou
		Given eu estou na minha lista de solicitacoes de amizade para mim
		When eu vejo que o usuario "Matheus" nao esta na lista de solicitacoes de amizade para mim
		And eu aceito um pedido de amizade feito pelo usuario "Matheus"
		Then eu vejo que nao eh possivel aceitar solicitacoes inexistentes

	Scenario: Erro ao recusar solicitacao de amizade de usuario inexistente
		Given eu estou na minha lista de solicitacoes de amizade para mim
		When eu recuso um pedido de amizade feito por um usuario que nao existe
		Then eu vejo que nao posso ser solicitado por um usuario que nao existe

	Scenario: Erro ao recusar solicitacao de amizade de usuario que nao solicitou
		Given eu estou na minha lista de solicitacoes de amizade para mim
		When eu vejo que o usuario "Matheus" nao esta na lista de solicitacoes de amizade para mim
		And eu recuso um pedido de amizade feito pelo usuario "Matheus"
		Then eu vejo que nao posso ser solicitado por um usuario que nao me solicitou

	Scenario: Desfazer amizade
		Given eu estou na minha lista de amizades
		When eu clico para ver o perfil do usuario "Matheus"
		And eu clico para desfazer amizade com o usuario "Matheus"
		And eu estou na pagina do meu perfil
		And eu vejo minha lista de amizades
		Then eu vejo que o usuario "Matheus" nao esta na minha lista de amizades

	Scenario: Erro ao desfazer amizade com usuario inexistente
		Given eu estou na minha lista de amizades
		When eu desfaco amizade com um usuario inexistente
		Then eu vejo que nao existe amizade com usuario inexistente

	Scenario: Erro ao desfazer amizade com usuario que nao eh amigo
		Given eu estou na minha lista de amizades
		When eu vejo que o usuario "Matheus" nao esta na minha lista de amizades
		And eu desfaco amizade com um usuario "Matheus"
		Then eu vejo que nao eh possivel uma vez que nao somos amigos
