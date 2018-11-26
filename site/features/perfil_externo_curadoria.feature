feature: Link para outros perfis
  As a usuario da rede social
  I want to linkar ao meu perfil da rede social, outros perfis provenientes
            de outras redes sociais ou sites
  So that eu possa melhorar a descricao sobre mim na rede social

  Scenario: Adicionando perfil externo
    Given que eu estou na aba de perfil externo do meu perfil da rede social
    When eu clico em adicionar novo perfil externo
    And preencho os campos de nome com nome "Facebook" de descricao com "Link para o meu perfil do facebook"
        e de link com o link "https://www.facebook.com/junior.escott"
    And clico em salvar perfil externo
    Then eu vejo que o perfil externo com nome "Facebook" com descricao "Link para o meu perfil do facebook"
        e com o link "https://www.facebook.com/junior.escott" foi adicionado ao meus perfis externos
