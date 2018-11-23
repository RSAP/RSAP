feature: Publicar um post
  As a usuario da rede social
  I want to publicar um post no mural do meu perfil
  So that eu precise apenas preencher as informacoes da postagem

  Scenario: Criando uma nova postagem
    Given que eu estou no mural do meu perfil
    When eu preencho o titulo "Exemplo de classe em Java" e o texto "public class Exemplo{ public int atributo}"
    And clico no botao de publicar nova postagem
    Then eu vejo que o post "Exemplo de classe em Java" foi publicado no meu mural com a devida formatacao

  Scenario: Apagando uma postagem
    Given que eu estou no mural do meu perfil
    And a postagem com titulo "Soma em assembly" e o texto ".text add $t0, $t1, $t2" existe
    When eu clico no botao deletar a postagem "Soma em assembly"
    Then a postagem "Soma em assembly" foi deletada e sumiu automaticamente do meu mural

  Scenario: Visualizando uma postagem
    Given que eu estou no mural do meu perfil
    And a postagem com titulo "Importando bibliotecas em C" e o texto "As bibliotecas em C são utilizadas da seguinte maneira:
        Digita-se '#include' e depois, entre  <> coloca-se o nome da biblioteca seguido de um .h exemplo:
        #include <NomeDaBiblioteca.h>" existe
    When eu clico em visualizar o post "Importando bibliotecas em C"
    Then surge um tela exibindo o titulo "Importando bibliotecas em C", texto "As bibliotecas em C são utilizadas da seguinte maneira:
        Digita-se '#include' e depois, entre  <> coloca-se o nome da biblioteca seguido de um .h exemplo:
        #include <NomeDaBiblioteca.h>" e comentarios do post

  Scenario: Editando uma postagem
    Given que eu estou no mural do meu perfil
    And a postagem com titulo "Comandos do rails" e o texto "Rodar servidor: bin/rails server" existe
    And eu aperto em visualizar o post "Comandos do rails"
    When eu clico no botao de editar o post "Comandos do rails"
    And eu preencho os campos do titulo com "Comandos do rails (atualizado)" e o texto com "Rodar servidor: bin/rails server,
        para usuarios do windows o comando eh: ruby bin/rails server"
    Then eu vejo que o post "Comandos do rails" foi atualizado para o novo titulo "Comandos do rails (atualizado)" e o novo texto "Rodar servidor:
        bin/rails server, para usuarios do windows o comando eh: ruby bin/rails server"

  Scenario: Criando post em branco
    Given que eu estou no mural do meu perfil
    When eu clico no botao Publicar sem preencher nenhum campo
    Then eu vejo um erro de campos invalidos
