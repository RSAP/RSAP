@GrupoTeste
Feature: Grupo
	As a usuario
	I want to ter a possibilidade de criar, participar e gerenciar grupos
	So that possibilitando assim maior interacao com os demais usuarios do sistema

	Scenario: Criacao de grupo
		Given eu estou logado no sistema
		And eu estou na pagina do meu perfil
		When eu clico no botao Grupos
		And eu clico no botao Novo Grupo
		And eu preencho o campo nome com "ES-2018.2" e descricao "Engenharia de Software"
		And eu clico no botao Criar
		Then eu vejo que o grupo com nome "ES-2018.2" e descricao "Engenharia de Software" foi criado

	Scenario: Criar grupo com campos invalidos
		Given eu estou logado no sistema
		And eu estou na pagina do meu perfil
		When eu clico no botao Grupos
		And eu clico no botao Novo Grupo
		And eu preencho o campo nome com "ES" e nao preencho o campo descricao
		And eu clico no botao Criar
		Then eu vejo a mensagem de erro "Nome muito curto"
		And eu vejo a mensagem de erro "Descricao em branco"

	Scenario: Editar grupo
		Given eu estou logado no sistema
		And eu crio um grupo com nome "ES-2018.3" e descricao "Engenharia de Sotwar"
		When eu clico em Editar
		And eu preencho o campo nome com "ES-2018.2" e descricao "Engenharia de Software"
		And eu crico em Editar
		Then eu vejo o grupo com nome "ES-2018.2" e descricao "Engenharia de Software"

	Scenario: Editar grupo com campos invalidos
		Given eu estou logado no sistema
		And eu crio um grupo com nome "ES-2018.3" e descricao "Engenharia de Sotwar"
		When eu clico em Editar
		And eu nao preencho o campo nome e preencho o campo descricao com "ES"
		And eu crico em Editar
		Then eu vejo a mensagem de erro "Nome em branco"
		And eu vejo a mensagem de erro "Descricao muito curta"


	Scenario: Aceitar solicitacao de entrada em grupo
		Given eu estou logado no sistema
		And eu crio um grupo com nome "BCC-CS:GO" e descricao "Bachareis em CS"
		And o usuario com nome "Carlos Pimentel" e email "carlux@yahoo.com.br" existe
		And o usuario com nome "Carlos Pimentel" e email "carlux@yahoo.com.br" envia pela primeira vez a solicitacao
			de entrada no grupo de nome "BCC-CS:GO"
		When eu estiver na pagina de solicitacoes do grupo com nome "BCC-CS:GO"
		And eu clico para aceitar a solicitacao do usuario com nome "Carlos Pimentel"
		Then eu vejo que o usuario com nome "Carlos Pimentel" agora faz parte do grupo

	Scenario: Recusar solicitacao de entrada em grupo
		Given eu estou logado no sistema
		And eu crio um grupo com nome "BCC-CS:GO" e descricao "Bachareis em CS"
		And o usuario com nome "Matheus Carlos" e email "methius@outlook.com.br" existe
		And o usuario com nome "Matheus Carlos" e email "methius@outlook.com.br" envia pela primeira vez a solicitacao
			de entrada no grupo de nome "BCC-CS:GO"
		When eu estiver na pagina de solicitacoes do grupo com nome "BCC-CS:GO"
		Then eu clico para recusar a solicitacao do usuario com nome "Matheus Carlos"
		And eu nao vejo mais a solicitacao
		And eu vejo que o usuario com nome "Matheus Carlos" nao faz parte do grupo


	Scenario:
		Given
		When
		Then
		And

	Scenario:
		Given
		When
		Then
		And

	Scenario:
		Given
		When
		Then
		And
