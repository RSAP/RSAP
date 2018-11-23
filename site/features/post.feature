feature: Publicar um post
  As a usuario da rede social
  I want to publicar um post no mural do meu perfil
  So that eu precise apenas preencher as informacoes da postagem

  Scenario: Criando uma nova postagem
    Given que eu estou no mural do meu perfil
    When eu preencho o titulo "title" e o texto "Codigo qualquer"
    And clico no botao publicar
    Then eu vejo que o post foi publicado no meu mural

  Scenario: Apagando uma postagem
    Given que eu estou no mural do meu perfil
    And a postagem com titulo "title" e o texto "Codigo qualquer" existe
    When eu clico no botao deletar a postagem "title"
    Then a postagem some do meu mural

  Scenario: Visualizando uma postagem
    Given que eu estou no mural do meu perfil
    And a postagem com titulo "title" e o texto "Codigo qualquer" existe
    When eu clico em visualizar o post
    Then uma tela com o post aparece
