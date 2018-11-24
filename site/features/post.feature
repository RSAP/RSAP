feature: Publicar um post
  As a usuario da rede social
  I want to publicar um post no mural do meu perfil
  So that eu precise apenas preencher as informacoes da postagem

  Scenario: Criando uma nova postagem
    Given que eu estou no mural do meu perfil
    And eu clico no botao novo post
    When eu preencho o titulo "Exemplo de classe em Java" e o texto ";;lang=java<br> public class Exemplo{ public int atributo}"
    And clico no botao de publicar nova postagem
    Then eu vejo que o post "Exemplo de classe em Java" foi publicado no meu mural com a devida formatacao

  Scenario: Apagando uma postagem
    Given que eu estou no mural do meu perfil
    And a postagem com titulo "Soma em assembly" e o texto ";;lang=asm6502<br> .text add $t0, $t1, $t2" existe
    When eu clico no botao deletar a postagem "Soma em assembly"
    Then a postagem "Soma em assembly" foi deletada e sumiu automaticamente do meu mural

  Scenario: Visualizando uma postagem
    Given que eu estou no mural do meu perfil
    And a postagem com titulo "Importando bibliotecas em C" e o texto "As bibliotecas em C são utilizadas da seguinte maneira:
        Digita-se '#include' e depois, entre  <> coloca-se o nome da biblioteca seguido de um .h exemplo:
        ;;lang=c<br> #include <NomeDaBiblioteca.h>" existe
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

  Scenario: Postando um link
    Given que eu estou no mural do meu perfil
    And eu clico no botao novo post
    When eu preencho o titulo "Link para o meu repositorio no github" e o texto "https://github.com/mrjonio/rsap"
    And clico no botao de publicar nova postagem
    And eu clico no link "https://github.com/mrjonio/rsap" da nova postagem "Link para o meu repositorio no github"
    Then eu sou redirecionado para "https://github.com/mrjonio/rsap"

  Scenario: Editando um post com novos dados em branco
    Given que eu estou no mural do meu perfil
    And a postagem com titulo "Visibilidade de atributos em JAVA" e o texto "- public: para atributos com visibilidade total
        - private: para atributos com visibilidade apenas na classe e - protected: para atributos com visibilidade de pacote e
        heranca" existe
    And eu aperto em visualizar o post "Visibilidade de atributos em JAVA"
    When eu clico no botao de editar o post "Visibilidade de atributos em JAVA"
    And eu não preencho os campos do titulo e do texto
    Then eu vejo um erro de campos invalidos
