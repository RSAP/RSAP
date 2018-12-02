Feature: Perfis externos
  As a usuario da rede social
  I want to conectar ao meu perfil da rede social, outros perfis provenientes de outras redes sociais ou sites
  So that eu possa melhorar a descricao sobre mim na rede social

  Scenario: Adicionando perfil externo
    Given eu estou na aba de perfis externos do meu perfil da rede social
    When eu clico em adicionar novo perfil externo
    And preencho os campos de nome com nome "Facebook" de descricao com "Link para o meu perfil do facebook" e de link com o link "https://www.facebook.com/junior.escott"
    And clico em salvar perfil externo
    Then eu vejo que o perfil externo com nome "Facebook" com descricao "Link para o meu perfil do facebook" e com o link "https://www.facebook.com/junior.escott" foi adicionado ao meus perfis externos

  Scenario: Removendo um perfil externo existente
    Given eu estou na aba de perfis externos do meu perfil da rede social
    And eu possuo um perfil externo com nome "Github" com descricao "Link para o meu perfil do github" e com o link "https://github.com/mrjonio"
    When eu clico para remover o perfil externo com nome "Github"
    Then eu vejo que o perfil externo com nome "Github" com descricao "Link para o meu perfil do github" e com o link "https://github.com/mrjonio" foi removido da area de perfis externos do meu perfil automaticamente

  Scenario: Editando um perfil externo existente
    Given eu estou na aba de perfis externos do meu perfil da rede social
    And eu possuo um perfil externo com nome "Twitter" com descricao "Link para o meu perfil do twitter" e com o link "https://github.com/mrjonio"
    When eu clico para editar o perfil externo com nome "Twitter"
    And preencho os campos de nome com nome "Twitter" de descricao com "Link para o meu perfil do twitter (Atualizado)" e de link com o link "https://twitter.com/supremejuniorsk"
    And clico no botar de salvar
    Then eu percebo que o perfil externo "Twitter" foi atualizado com a nova descricao e o novo link

  Scenario: Adicionando perfil externo sem nome
    Given eu estou na aba de perfis externos do meu perfil da rede social
    When eu clico em adicionar novo perfil externo
    And preencho os campos de descricao com "Link para o meu perfil do facebook" e de link com o link "https://www.facebook.com/junior.escott" e nao preencho o campo de nome
    And clico em salvar perfil externo
	Then eu vejo a mensagem de erro "Nome em branco"

  Scenario: Adicionando perfil externo sem link
    Given eu estou na aba de perfis externos do meu perfil da rede social
    When eu clico em adicionar novo perfil externo
    And preencho os campos de nome com "Facebook" descricao com "Link para o meu perfil do facebook" e nao preencho o campo de link
    And clico em salvar perfil externo
	Then eu vejo a mensagem de erro "Link em branco"

  Scenario: Adicionando perfil externo em branco
    Given eu estou na aba de perfis externos do meu perfil da rede social
    When eu clico em adicionar novo perfil externo
    And eu nao preencho nenhum dos campos
    And clico em salvar perfil externo
	Then eu vejo a mensagem de erro "Nome em branco"
	And eu vejo a mensagem de erro "Link em branco"

  Scenario: Editando perfil externo com nome invalido
    Given eu estou na aba de perfis externos do meu perfil da rede social
    And eu possuo um perfil externo com nome "Github" com descricao "Link para o meu perfil do github" e com o link "https://github.com/mrjonio"
    When eu clico para editar o perfil externo com nome "Github"
    And preencho os campos de descricao com "Link para o meu perfil do facebook" e de link com o link "https://www.facebook.com/junior.escott" e nao preencho o campo de nome
    And clico em salvar perfil externo
	Then eu vejo a mensagem de erro "Nome invalido"

  Scenario: Editando perfil externo com link invalido
    Given eu estou na aba de perfis externos do meu perfil da rede social
    And eu possuo um perfil externo com nome "Github" com descricao "Link para o meu perfil do github" e com o link "https://github.com/mrjonio"
    When eu clico para editar o perfil externo com nome "Github"
    And preencho os campos de nome com "Github (novo)" com "Link para o meu novo perfil do Github" e nao preencho o campo de link
    And clico em salvar perfil externo
	Then eu vejo a mensagem de erro "Link invalido"

  Scenario: Editando perfil externo com novos dados em branco
    Given eu estou na aba de perfis externos do meu perfil da rede social
    And eu possuo um perfil externo com nome "Github" com descricao "Link para o meu perfil do github" e com o link "https://github.com/mrjonio"
    When eu clico para editar o perfil externo com nome "Github"
    And eu nao preencho nenhum dos campos
    And clico em salvar perfil externo
	Then eu vejo a mensagem de erro "Nome em branco"
	And eu vejo a mensagem de erro "Link em branco"

  Scenario: Editando um perfil externo de outro usuario
    Given eu estou no mural do meu perfil
    And o perfil do usuario "Mateus Baltazar" existe
    When eu tento editar o perfil externo do perfil do usuario "Mateus Baltazar"
	Then eu vejo a mensagem de erro "Acesso negado"

  Scenario: Excluido um perfil externo de outro usuario
    Given eu estou no mural do meu perfil
    And o perfil do usuario "Mateus Baltazar" existe
    When eu tento excluir o perfil externo do usuario "Mateus Baltazar"
	Then eu vejo a mensagem de erro "Acesso negado"

  Scenario: Acessando perfil externo de um perfil amigo
    Given eu estou no mural do meu perfil
    And o perfil do usuario "Mateus Baltazar" existe
    And o perfil do usuario "Mateus Baltazar" eh meu amigo na rede social
    And o perfil do usuario "Mateus Baltazar" possui um perfil externo com nome "Github"
    When eu acesso o perfil do usuario "Mateus Baltazar"
    And clico em perfis externos do perfil do usuario "Mateus Baltazar"
    And eu clico em visualizar o perfil externo com nome "Github" do usuario "Mateus Baltazar"
    Then eu vejo o perfil externo externo de nome "Github" do usuario "Mateus Baltzar"

  Scenario: Editando perfil externo de um perfil inexistente
    Given eu estou no mural do meu perfil
    When eu tento editar o perfil externo do perfil de um usuario que nao existe
	Then eu vejo a mensagem de erro "Perfil inexistente"

  Scenario: Excluindo perfil externo de um perfil inexistente
    Given eu estou no mural do meu perfil
    When eu tento excluir o perfil externo de um usuario que nao existe
	Then eu vejo a mensagem de erro "Perfil inexistente"

  Scenario: Editar perfil externo sem estar logado na rede social
    Given eu estou na pagina inicial da rede
    And eu nao estou logado em meu perfil da rede social
    And o perfil do usuario "Carlos Antonio" esta cadastrado
    When eu tento editar o perfil externo do usuario "Carlos Antonio"
    Then eu sou redirecionado para a pagina de login da rede

  Scenario: Excluir perfil externo sem estar logado na rede social
    Given eu estou na pagina inicial da rede social
    And eu nao estou logado em meu perfil da rede social
    And o perfil do usuario "Carlos Antonio" esta cadastrado
    When eu tento excluir o perfil externo do usuario "Carlos Antonio"
    Then eu sou redirecionado para a pagina de login da rede
