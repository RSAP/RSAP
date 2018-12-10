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

	Scenario: Editar grupo
		Given eu estou logado no sistema
		And eu crio um grupo com nome "ES-2018.3" e descricao "Engenharia de Sotwar"
		When eu clico em Editar
		And eu preencho o campo nome com "ES-2018.2" e descricao "Engenharia de Software"
		And eu crico em Editar
		Then eu vejo o grupo com nome "ES-2018.2" e descricao "Engenharia de Software"

	Scenario: Aceitar solicitacao de entrada em grupo
		Given eu estou logado no sistema
		And eu crio um grupo com nome "BCC-CS:GO" e descricao "Bachareis em CS"
		And o usuario com nome "Carlos Pimentel" e email "carlux@yahoo.com.br" existe
		And o usuario com nome "Carlos Pimentel" e email "carlux@yahoo.com.br" envia pela primeira vez a solicitacao de entrada no grupo de nome "BCC-CS:GO"
		When eu estiver na pagina de solicitacoes do grupo com nome "BCC-CS:GO"
		And eu clico para aceitar a solicitacao do usuario com nome "Carlos Pimentel"
		Then eu vejo que o usuario com nome "Carlos Pimentel" agora faz parte do grupo

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
