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
    When eu busco pelo perfil externo pelo nome "Github"
    And clico no botao de remover perfil externo do perfil externo com nome "Github"
    Then eu vejo que o perfil externo com nome "Github" com descricao "Link para o meu perfil do github"
        e com o link "https://github.com/mrjonio" foi removido da area de perfis externos do meu perfil automaticamente

  Scenario: Editando um perfil externo existente
    Given que eu estou na aba de perfis externos do meu perfil da rede social
    And eu possuo um perfil externo com nome "Twitter" com descricao "Link para o meu perfil do twitter"
      e com o link "https://github.com/mrjonio"
    When eu busco pelo perfil externo pelo nome "Twitter"
    And clico no botao de editar perfil externo do perfil externo "Twitter"
    And preencho os campos de nome com nome "Twitter" de descricao com "Link para o meu perfil do twitter (Atualizado)"
        e de link com o link "https://twitter.com/supremejuniorsk"
    And clico no botar de salvar
    Then eu percebo que o perfil externo "Twitter" foi atualizado com a nova descricao e o novo link
