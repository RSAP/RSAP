feature: Publicar um post
  As a usuario da rede social
  I want to publicar um post no mural do meu perfil
  So that eu precise apenas preencher as informacoes da postagem

  Scenario: Criando uma nova postagem
    Given que eu estou no mural do meu perfil
    When eu preencho o titulo "title" e o texto "Codigo qualquer"
    And clico no botao publicar
    Then eu vejo que o post foi publicado no meu mural
