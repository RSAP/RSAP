feature: Publicar um post
  As a usuario da rede social
  I want to publicar um post no mural do meu perfil
  So that eu precise apenas preencher as informacoes da postagem

  Scenario: Criando uma nova postagem
    Given que eu estou no mural do meu perfil
    When eu preencho o titulo "Nova Postagem" e o texto "Codigo qualquer"
    And clico no botao publicar
    Then eu vejo que o post "Nova Postagem" foi publicado no meu mural

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

  Scenario: Editando uma postagem
    Given que eu estou no mural do meu perfil
    And a postagem com titulo "title" e o texto "Codigo qualquer" existe
    And eu aperto em visualizar a postagem
    When eu clico no botao de editar a postagem
    And eu preencho os campos titulo "Novo" e texto "Codigo novo"
    Then eu vejo que o post foi atualizado

Scenario: Criando post em branco
  Given que eu estou no mural do meu perfil
  When eu clico no botao Publicar
  Then eu vejo uma mensagem de erro campos invalidos
