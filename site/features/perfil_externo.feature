feature: Link para outros perfis
  As a usuario da rede social
  I want to linkar ao meu perfil da rede social, outros perfis provenientes
            de outras redes sociais ou sites
  So that eu possa melhorar a descricao sobre mim na rede social

  Scenario: Adicionando perfil externo
    Given que eu estou na aba de perfis externos do meu perfil da rede social
    When eu clico em adicionar novo perfil externo
    And preencho os campos de nome com nome "Facebook" de descricao com "Link para o meu perfil do facebook"
        e de link com o link "https://www.facebook.com/junior.escott"
    And clico em salvar perfil externo
    Then eu vejo que o perfil externo com nome "Facebook" com descricao "Link para o meu perfil do facebook"
        e com o link "https://www.facebook.com/junior.escott" foi adicionado ao meus perfis externos

  Scenario: Removendo um perfil externo existente
    Given que eu estou na aba de perfis externos do meu perfil da rede social
    And eu possuo um perfil externo com nome "Github" com descricao "Link para o meu perfil do github"
        e com o link "https://github.com/mrjonio"
    When eu clico no botao de remover perfil externo do perfil externo com nome "Github"
    Then eu vejo que o perfil externo com nome "Github" com descricao "Link para o meu perfil do github"
        e com o link "https://github.com/mrjonio" foi removido da area de perfis externos do meu perfil automaticamente

  Scenario: Editando um perfil externo existente
    Given que eu estou na aba de perfis externos do meu perfil da rede social
    And eu possuo um perfil externo com nome "Twitter" com descricao "Link para o meu perfil do twitter"
      e com o link "https://github.com/mrjonio"
    When eu clico no botao de editar perfil externo do perfil externo "Twitter"
    And preencho os campos de nome com nome "Twitter" de descricao com "Link para o meu perfil do twitter (Atualizado)"
        e de link com o link "https://twitter.com/supremejuniorsk"
    And clico no botar de salvar
    Then eu percebo que o perfil externo "Twitter" foi atualizado com a nova descricao e o novo link

  Scenario: Adicionando perfil externo sem nome
    Given que eu estou na aba de perfis externos do meu perfil da rede social
    When eu clico em adicionar novo perfil externo
    And preencho os campos de descricao com "Link para o meu perfil do facebook"
        e de link com o link "https://www.facebook.com/junior.escott" e nao preencho o campo de nome
    And clico em salvar perfil externo
    Then eu vejo uma mensagem de erro campos invalidos

  Scenario: Adicionando perfil externo sem link
    Given que eu estou na aba de perfis externos do meu perfil da rede social
    When eu clico em adicionar novo perfil externo
    And preencho os campos de nome com "Facebook" descricao com "Link para o meu perfil do facebook"
        e nao preencho o campo de link
    And clico em salvar perfil externo
    Then eu vejo uma mensagem de erro campos invalidos

  Scenario: Adicionando perfil externo em branco
    Given que eu estou na aba de perfis externos do meu perfil da rede social
    When eu clico em adicionar novo perfil externo
    And eu nao preencho nenhum dos campos
    And clico em salvar perfil externo
    Then eu vejo uma mensagem de erro campos invalidos

  Scenario: Editando perfil externo com nome invalido
    Given que eu estou na aba de perfis externos do meu perfil da rede social
    And eu possuo um perfil externo com nome "Github" com descricao "Link para o meu perfil do github"
        e com o link "https://github.com/mrjonio"
    When eu clico no botao de editar perfil externo do perfil externo "Github"
    And preencho os campos de descricao com "Link para o meu perfil do facebook"
        e de link com o link "https://www.facebook.com/junior.escott" e nao preencho o campo de nome
    And clico em salvar perfil externo
    Then eu vejo uma mensagem de erro campos invalidos

  Scenario: Editando perfil externo com link invalido
    Given que eu estou na aba de perfis externos do meu perfil da rede social
    And eu possuo um perfil externo com nome "Github" com descricao "Link para o meu perfil do github"
        e com o link "https://github.com/mrjonio"
    When eu clico no botao de editar perfil externo do perfil externo "Github"
    And preencho os campos de nome com "Github (novo)" com "Link para o meu novo perfil do Github"
        e nao preencho o campo de link
    And clico em salvar perfil externo
    Then eu vejo uma mensagem de erro campos invalidos

  Scenario: Editando perfil externo com novos dados em branco
    Given que eu estou na aba de perfis externos do meu perfil da rede social
    And eu possuo um perfil externo com nome "Github" com descricao "Link para o meu perfil do github"
        e com o link "https://github.com/mrjonio"
    When eu clico no botao de editar perfil externo do perfil externo "Github"
    And eu nao preencho nenhum dos campos
    And clico em salvar perfil externo
    Then eu vejo uma mensagem de erro campos invalidos

  Scenario: Editando um perfil externo de um perfil de outro usuario
    Given que eu estou no mural do meu perfil
    And o perfil do usuario "Mateus Baltazar" existe
    When eu tento editar o perfil externo do perfil do usuario "Mateus Baltazar"
    Then eu vejo uma mensagem de erro acesso negado

  Scenario: Excluido um perfil externo de um perfil de outro usuario
    Given que eu estou no mural do meu perfil
    And o perfil do usuario "Mateus Baltazar" existe
    When eu tento excluir o perfil externo do perfil do usuario "Mateus Baltazar"
    Then eu vejo uma mensagem de erro acesso negado

  Scenario: Acessando perfil externo de um perfil amigo
    Given que eu estou no mural do meu perfil
    And o perfil do usuario "Mateus Baltazar" existe
    And o perfil do usuario "Mateus Baltazar" eh meu amigo na rede social
    And o perfil do usuario "Mateus Baltazar" possui um perfil externo com nome "Github"
    When eu acesso o perfil do usuario "Mateus Baltazar"
    And clico em perfis externos do perfil do usuario "Mateus Baltazar"
    And eu clico em visualizar o perfil externo com nome "Github" do perfil do usuario "Mateus Baltazar"
    Then eu vejo o perfil externo externo de nome "Github" do perfil do usuario "Mateus Baltzar"

  Scenario: Editando perfil externo de um perfil inexistente
    Given que eu estou no mural do meu perfil
    When eu tento editar o perfil externo do perfil de um usuario que nao existe
    Then eu vejo uma mensagem de erro usuario inexistente

  Scenario: Excluindo perfil externo de um perfil inexistente
    Given que eu estou no mural do meu perfil
    When eu tento excluir o perfil externo do perfil de um usuario que nao existe
    Then eu vejo uma mensagem de erro usuario inexistente

  Scenario: Editar perfil externo sem estar logado na rede social
    Given que eu estou na pagina inicial da rede
    And o perfil do usuario "Carlos Antonio" esta cadastrado
    When eu tento editar o perfil externo do perfil do usuario "Carlos Antonio"
    Then eu sou redirecionado para a pagina de login da rede

  Scenario: Excluir perfil externo sem estar logado na rede social
    Given que eu estou na pagina inicial da rede social
    And o perfil do usuario "Carlos Antonio" esta cadastrado
    When eu tento excluir o perfil externo do perfil do usuario "Carlos Antonio"
    Then eu sou redirecionado para a pagina de login da rede
