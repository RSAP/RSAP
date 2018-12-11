@GrupoTeste
Feature: Grupo
	As a usuario da rede social
	I want to a possibilidade de criar, participar e gerenciar grupos
	So that possibile assim maior interacao com os demais usuarios do sistema

	Scenario: Criacao de grupo
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And eu estou na pagina do meu perfil
		When eu clico no botao Grupos
		And eu clico no botao Novo Grupo
		And eu preencho o campo nome com "ES-2018.2" e descricao "Engenharia de Software"
		And eu clico no botao Criar
		Then eu vejo que o grupo com nome "ES-2018.2" e descricao "Engenharia de Software" foi criado

	Scenario: Criar grupo com campos invalidos
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And eu estou na pagina do meu perfil
		When eu clico no botao Grupos
		And eu clico no botao Novo Grupo
		And eu preencho o campo nome com "ES" e nao preencho o campo descricao
		And eu clico em Confirmar edicao
		Then eu vejo a mensagem de erro "Nome muito curto"
		And eu vejo a mensagem de erro "Descricao em branco"

	Scenario: Editar grupo
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And eu crio um grupo com nome "ES-2018.3" e descricao "Engenharia de Sotwar"
		And eu estou na pagina principal do grupo de nome "ES-2018.3"
		When eu clico em Editar
		And eu preencho o campo nome com "ES-2018.2" e descricao "Engenharia de Software"
		And eu clico em Confirmar edicao
		Then eu vejo o grupo agora tem nome "ES-2018.2" e descricao "Engenharia de Software"

	Scenario: Editar grupo com campos invalidos
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And eu crio um grupo com nome "ES-2018.3" e descricao "Engenharia de Sotwar"
		When eu clico em Editar
		And eu nao preencho o campo nome e preencho o campo descricao com "ES"
		And eu clico em Confirmar edicao
		Then eu vejo a mensagem de erro "Nome em branco"
		And eu vejo a mensagem de erro "Descricao muito curta"

	Scenario: Deletar grupo
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And eu crio um grupo com nome "PLP-EaD" e descricao "Educacao a Distancia"
		When eu clico em Apagar
		And eu confirmo que quero apagar o grupo
		Then eu vejo que o grupo foi apagado com sucesso

	Scenario: Buscar grupo
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And eu crio um grupo com nome "Matematica Discreta" e descricao "Prof Gersonilo ; Discreta"
		And eu estou na pagina do meu perfil
		When eu clico no botao Grupos
		And eu preencho o campo de busca com nome "Matematica Discreta"
		And eu clico em Buscar
		Then eu vejo o grupo que criei com nome "Matematica Discreta" e descricao "Prof Gersonilo ; Discreta"

	Scenario: Ver grupos que participo
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And eu participo de um grupo com nome "Criptografia RSA"
		And eu crio um grupo com nome "Matematica Discreta" e descricao "Prof Gersonilo ; Discreta"
		And eu estou na pagina do meu perfil
		When eu clico no botao Grupos
		And eu clico no botao Meus grupos
		Then eu vejo o grupo com nome "Matematica Discreta"
		And eu vejo o grupo com nome "Criptografia RSA"

	Scenario: Aceitar solicitacao de entrada em grupo
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And eu crio um grupo com nome "BCC-CS:GO" e descricao "Bachareis em CS"
		And o usuario com nome "Carlos Pimentel" e email "carlux@yahoo.com.br" existe
		And o usuario com nome "Carlos Pimentel" e email "carlux@yahoo.com.br" envia pela primeira vez a solicitacao
			de entrada no grupo de nome "BCC-CS:GO"
		And eu estou na pagina de solicitacoes do grupo de nome "BCC-CS:GO"
		When eu clico para aceitar a solicitacao do usuario de nome "Carlos Pimentel"
		Then eu nao vejo que a solicitacao nao existe mais
		And eu vejo que o usuario com nome "Carlos Pimentel" faz parte do grupo

	Scenario: Recusar solicitacao de entrada em grupo
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And eu crio um grupo com nome "BCC-CS:GO" e descricao "Bachareis em CS"
		And o usuario com nome "Matheus Carlos" e email "methius@outlook.com.br" existe
		And o usuario com nome "Matheus Carlos" e email "methius@outlook.com.br" envia pela primeira vez a solicitacao
			de entrada no grupo de nome "BCC-CS:GO"
		And eu estou na pagina de solicitacoes do grupo de nome "BCC-CS:GO"
		When eu clico para recusar a solicitacao do usuario de nome "Matheus Carlos"
		Then eu nao vejo que a solicitacao nao existe mais
		And eu vejo que o usuario com nome "Matheus Carlos" nao faz parte do grupo

	Scenario: Sair do grupo
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And eu crio um grupo com nome "ES-2018.3" e descricao "Engenharia de Sotwar"
		When eu clico em Sair do grupo
		And eu confirmo que quero sair do grupo
		Then eu vejo que nao participo mais do grupo

	Scenario: Sair do grupo composto por outros integrantes que nao sao administradores
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And eu crio um grupo com nome "Arquitetura-EaD" e descricao "Arquitetura - Educacao a Distancia"
		And o usuario com nome "Waldi Diax" e email "wdiax@yahoo.com.br" existe
		And o usuario com nome "Waldi Diax" e email "wdiax@yahoo.com.br" faz parte do meu grupo de nome "Arquitetura-EaD"
		And o usuario com nome "Waldi Diax" nao eh administrador do grupo
		And eu estou na pagina principal do grupo "Arquitetura-EaD"
		When eu clico em Sair do grupo
		Then eu vejo a mensagem de erro "Voce eh o unico administrador do grupo. Um grupo nao pode ficar sem administrador."

	Scenario: Remover usuario integrante do grupo
		Given o grupo com nome "Arquitetura-EaD" e descricao "Arquitetura - Educacao a Distancia" existe
		And eu sou administrador do grupo de nome "Arquitetura-EaD"
		And o usuario com nome "Waldi Diax" e email "wdiax@yahoo.com.br" faz parte do grupo de nome "Arquitetura-EaD"
		And eu estou na pagina que lista os integrantes do grupo
		When eu clico para remover o usuario "Waldi Diax"
		And eu confirmar a remocao
		Then eu vejo que o usuario com nome "Waldi Diax" nao faz mais parte do grupo

	Scenario: Tornar administrador outro integrante do grupo
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And eu crio um grupo com nome "Arquitetura-EaD" e descricao "Arquitetura - Educacao a Distancia"
		And o usuario com nome "Waldi Diax" e email "wdiax@yahoo.com.br" existe
		And o usuario com nome "Waldi Diax" e email "wdiax@yahoo.com.br" faz parte do meu grupo de nome "Arquitetura-EaD"
		And eu estou na pagina que lista todos os usuarios que fazem parte do grupo
		When eu clico para tornar o usuario "Waldi Diax" administrador do grupo
		Then eu vejo que o usuario "Waldi Diax" eh administrador do grupo

	Scenario: Realizar post no grupo
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And eu crio um grupo com nome "BCC-GameFest" e descricao "Evento de games na UAG!"
		And eu estou na pagina principal do grupo
		When eu clico em Novo post
		And eu preencho o campo titulo com "Counter-Strike" e o campo texto com "CS sera jogado na quarta e sexta"
		And eu clico para criar o post
		Then eu vejo na pagina principal do grupo o meu post com titulo "Counter Strike" e texto "CS sera jogado na quarta e sexta"

	Scenario: Visualizar no grupo posts feitos por outros usuarios
		Given eu estou logado no sistema com nome "Paulo", email "paul0@gmail.com" e senha "shuashu@"
		And o grupo com nome "Tutoria de Fisica" e descricao "Fisica - 2018.2" existe
		And o usuario com nome "Laisy Ferreira" e email "laisyriscafaca@live.com" existe
		And o usuario "Laisy Ferreira" faz parte do grupo "Tutoria de Fisica"
		And o usuario "Laisy Ferreira" fez um post no grupo "Tutoria de Fisica" com titulo "Atividade" e
			texto "Questoes de 1 a 21 da pagina 523"
		And eu participo do grupo "Tutoria de Fisica"
		When eu estou na pagina inicial do grupo
		Then eu vejo o post que o usuario "Laisy Ferreira" fez com titulo "Atividade" e texto "Questoes de 1 a 21 da pagina 523"
