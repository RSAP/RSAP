Feature: Amizades
	As a usuario
	I want to ser capaz de encontrar o perfil de outros usuarios para gerar relacionamentos e ver informações
	So that que eu posso estar em uma iteração social

	Scenario: Encontrar uma pessoa na rede
		Given Eu estou na pagina de feed
		When Eu clico para buscar um usuario
		And Eu preencho o campo de nome com "Matheus"
		And Eu clico em buscar
		Then Eu devo ver que existe um usuario chamado "Matheus"

	Scenario: Vizualizar perfil de uma pessoa na rede
		Given Eu estou na pagina de feed
		When Eu clico para buscar um usuario
		And Eu preencho o campo de nome com "Matheus"
		And Eu clico em buscar
		And Eu vejo que existe um usuario chamado "Matheus"
		And Eu clico para ver o perfil do usuario "Matheus"
		Then Eu estou na pagina do perfil do usuario "Matheus"

	Scenario: Perfil deve conter o email do usuario
		Given Eu procuro o usuario "Matheus"
		When Eu clico para ver o perfil do usuario "Matheus"
		Then Eu vejo que contem o email "matheus@email.com"

	Scenario: Enviar solicitacao de amizade
		Given Eu procuro o usuario "Matheus"
		When Eu solicito a amizade do usuario "Matheus"
		Then Eu vejo que minha solicitacao foi enviada

	Scenario: Erro ao solicitar um usuario inexistente
		Given Eu estou na pagina de perfil do usuario "Matheus"
		When Eu envio uma solicitacao para um usuario inexistente
		Then Eu vejo que o usuario solicitado nao existe

	Scenario: Erro ao solicitar amizade a mim mesmo
		Given Eu estou no meu proprio perfil
		When Eu solicito amizade a mim mesmo
		Then Eu vejo que eu não posso solicitar amizade a mim mesmo

	Scenario: Erro ao cancelar solicitacao de amizade a mim mesmo
		Given Eu estou no meu proprio perfil
		When Eu cancelo a solicitacao de amizade a mim mesmo
		Then Eu vejo que eu não posso cancelar uma solicitacao enviada a mim mesmo

	Scenario: Erro ao solicitar amizade de usuario que ja eh amigo
		Given Eu estou na pagina de perfil do usuario "Matheus"
		When Eu vejo que o usuario "Matheus" ja eh meu amigo
		And Eu envio uma solicitacao de amizade para o usuario "Matheus"
		Then Eu vejo que ja somos amigos e por isso nao foi solicitada a amizade

	Scenario: Erro ao solicitar amizade enquanto uma solicitacao esta pendente
		Given Eu estou na pagina de perfil do usuario "Matheus"
		When Eu solicito a amizade do usuario "Matheus"
		And Eu estou na pagina de perfil do usuario "Matheus"
		And Eu solicito a amizade do usuario "Matheus"
		Then Eu vejo que ja existe uma solicitacao pendente e por isso nao eh solicitado novamente

	Scenario: Erro ao cancelar solicitacao de um usuario inexistente
		Given Eu estou na pagina do meu perfil
		When Eu vejo minha lista de amizades
 		And Eu cancelo uma solicitacao para um usuario inexistente
		Then Eu vejo que nao existe uma solicitacao para um usuario que nao existe

	Scenario: Aceitar solicitacao de amizade
		Given Eu estou na pagina do meu perfil
		When Eu vejo minha lista de amizades
		And Eu vejo que o usuario "Matheus" nao esta na lista de amizades
		And Eu estou na pagina do meu perfil
		And Eu clico para ver minha minha lista de solicitacies de amizade para mim
		And Eu vejo que o usuario "Matheus" esta na lista de solicitacoes de amizade
		And Eu aceito a solicitacao do usuario "Matheus"
		And Eu estou na pagina do meu perfil
		And Eu vejo minha lista de amizades
		Then Eu vejo que o usuario "Matheus" esta na lista de amizades

	Scenario: Recusar solicitacao de amizade
		Given Eu estou na pagina do meu perfil
		And Eu clico para ver minha minha lista de solicitacies de amizade para mim
		And Eu vejo que o usuario "Matheus" esta na lista de solicitacoes de amizade
		And Eu recuso a solicitacao do usuario "Matheus"
		Then Eu vejo que o usuario "Matheus" nao esta na lista de solicitacoes de amizade

	Scenario: Erro ao aceitar solicitacao de amizade de usuario inexistente
		Given Eu estou na pagina do meu perfil
		When Eu clico para ver minha minha lista de solicitacies de amizade para mim
		And Eu aceito um pedido de amizade feito por um usuario que nao existe
		Then Eu vejo que não posso ser solicitado por um usuario que nao existe

	Scenario: Erro ao aceitar solicitacao de amizade de usuario que nao solicitou
		Given Eu estou na pagina do meu perfil
		When Eu clico para ver minha minha lista de solicitacies de amizade para mim
		And Eu vejo que o usuario "Matheus" nao esta na lista de solicitacoes de amizade
		And Eu aceito um pedido de amizade feito pelo usuario "Matheus"
		Then Eu vejo que não posso ser solicitado por um usuario que nao me solicitou

	Scenario: Erro ao recusar solicitacao de amizade de usuario inexistente
		Given Eu estou na pagina do meu perfil
		When Eu clico para ver minha minha lista de solicitacies de amizade para mim
		And Eu recuso um pedido de amizade feito por um usuario que nao existe
		Then Eu vejo que não posso ser solicitado por um usuario que nao existe

	Scenario: Erro ao recusar solicitacao de amizade de usuario que nao solicitou
		Given Eu estou na pagina do meu perfil
		When Eu clico para ver minha minha lista de solicitacies de amizade para mim
		And Eu vejo que o usuario "Matheus" nao esta na lista de solicitacoes de amizade
		And Eu recuso um pedido de amizade feito pelo usuario "Matheus"
		Then Eu vejo que não posso ser solicitado por um usuario que nao me solicitou

	Scenario: Desfazer amizade
		Given Eu estou na pagina do meu perfil
		When Eu vejo minha lista de amizades
		And Eu clico para ver o perfil do usuario "Matheus"
		And Eu clico para desfazer amizade com o usuario "Matheus"
		And Eu estou na pagina do meu perfil
		And Eu vejo minha lista de amizades
		Then Eu vejo que o usuario "Matheus" nao esta na minha lista de amizades

	Scenario: Erro ao desfazer amizade com usuario inexistente
		Given Eu estou na pagina do meu perfil
		When Eu vejo minha lista de amizades
		And Eu desfaco amizade com um usuario inexistente
		Then Eu vejo que nao existe amizade com usuario inexistente

	Scenario: Erro ao desfazer amizade com usuario que nao eh amigo
		Given Eu estou na pagina do meu perfil
		When Eu vejo minha lista de amizades
		When Eu vejo que o usuario "Matheus" nao esta na minha lista de amizades
		And Eu desfaco amizade com um usuario "Matheus"
		Then Eu vejo que nao eh possivel uma vez que nao somos amigos
