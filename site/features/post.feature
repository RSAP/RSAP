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
    And a postagem com titulo "Nova Postagem" e o texto "Codigo qualquer" existe
    When eu clico no botao deletar a postagem "Nova Postagem"
    Then a postagem "Nova Postagem" some do meu mural

  Scenario: Visualizando uma postagem
    Given que eu estou no mural do meu perfil
    And a postagem com titulo "Postagem Existente" e o texto "Codigo qualquer" existe
    When eu clico em visualizar o post "Postagem Existente"
    Then surge um tela exibindo o titulo, texto e comentarios do post "Postagem Existente"

  Scenario: Editando uma postagem
    Given que eu estou no mural do meu perfil
    And a postagem com titulo "Postagem Antiga" e o texto "Codigo qualquer" existe
    And eu aperto em visualizar o post "Postagem Antiga"
    When eu clico no botao de editar o post "Postagem Antiga"
    And eu preencho os campos do titulo com "Novo titulo" e o texto com "Codigo novo"
    Then eu vejo que o post "Postagem Antiga" foi atualizado para "Novo titulo"

Scenario: Criando post em branco
  Given que eu estou no mural do meu perfil
  When eu clico no botao Publicar sem preencher nenhum campo
  Then eu vejo um erro de campos invalidos
