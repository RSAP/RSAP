module LoginHelper

	@nick = ''
	@link = ''
	@oldNick = ''

	def criarPost(titulo, texto, id)
		visit '/'
		visit '/mural/' + id.to_s
		expect(page).to have_content(@nick)
		click_link 'Novo Post'
		expect(page).to have_content('New Post')
		fill_in 'post[titulo]', :with=> titulo
		fill_in 'post[texto]', :with=> texto
		click_button 'Create Post'
		expect(page).to have_content('Titulo: ' + titulo)
		expect(page).to have_content('Texto: ' + texto)
		click_link 'Back'
	end


	def registrar(email, senha)
		visit '/'
		visit 'users/sign_up'
		expect(page).to have_content('Registro')
		fill_in 'user[email]', :with=> email
		fill_in 'user[password]', :with=> senha
		fill_in 'user[password_confirmation]', :with=> senha
		fill_in 'user[nome]', :with=> 'Testadeiro'
		fill_in 'user[descricao]', :with=> 'Testando'
		click_button 'Registrar'
		expect(page).to have_content('Você está logado!!')
		@oldNick = @nick
		@nick = email.capitalize.split('@').first
	end

	def registrarComNome(email, senha, nome)
		visit '/'
		visit 'users/sign_up'
		expect(page).to have_content('Registro')
		fill_in 'user[email]', :with=> email
		fill_in 'user[password]', :with=> senha
		fill_in 'user[password_confirmation]', :with=> senha
		fill_in 'user[nome]', :with=> nome
		fill_in 'user[descricao]', :with=> 'Testando'
		click_button 'Registrar'
		expect(page).to have_content('Você está logado!!')
		@oldNick = @nick
		@nick = email.capitalize.split('@').first
	end

	def deslogar()
		browser = Capybara.current_session.driver.browser
		if browser.respond_to?(:clear_cookies)
			# Rack::MockSession
			browser.clear_cookies
		elsif browser.respond_to?(:manage) and browser.manage.respond_to?(:delete_all_cookies)
			# Selenium::WebDriver
			browser.manage.delete_all_cookies
		else
			raise "Don't know how to clear cookies. Weird driver?"
		end
	end

	def login(email, senha)
		visit '/'
		visit 'users/sign_in'
		expect(page).to have_content('Logar')
		fill_in 'user[email]', :with=> email
		fill_in 'user[password]', :with=> senha
		click_button 'Logar'
	end

end

World LoginHelper

Given("eu estou logado no meu perfil da rede social com o email {string} e senha {string}") do |email, senha|
	registrar(email, senha)
end

Given("existe um usuario registrado com nome {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu clico para buscar um usuario") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu preencho o campo de nome com {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu clico em buscar") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu devo ver que existe um usuario chamado {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu vejo que existe um usuario chamado {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu clico para ver o perfil do usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("Eu vejo a pagina do perfil do usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu procuro o usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu vejo que o perfil contem o email {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu solicito a amizade do usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu vejo que minha solicitacao foi enviada") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu estou na pagina de perfil do usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu envio uma solicitacao para um usuario inexistente") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu vejo a mensagem de erro {string}") do |erro|
	expect(page).to have_content(erro)

end

Given("eu estou no meu proprio perfil") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu solicito amizade a mim mesmo") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu cancelo a solicitacao de amizade a mim mesmo") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu vejo que o usuario {string} ja eh meu amigo") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu envio uma solicitacao de amizade para o usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu estou na pagina de perfil do usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu vejo minha lista de amizades") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu cancelo uma solicitacao para um usuario inexistente") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu vejo que o usuario {string} nao esta na lista de amizades") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu estou na minha lista de solicitacoes de amizade para mim") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu vejo que o usuario {string} esta na lista de solicitacoes de amizade") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu aceito a solicitacao do usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu vejo minha lista de amizades") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu vejo que o usuario {string} esta na lista de amizades") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu estou na minha lista de solicitacoes de amizade para mim") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu vejo que o usuario {string} esta na lista de solicitacoes de amizade para mim") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu recuso a solicitacao do usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu vejo que o usuario {string} nao esta na lista de solicitacoes de amizade para mim") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu aceito um pedido de amizade feito por um usuario que nao existe") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu vejo que o usuario {string} nao esta na lista de solicitacoes de amizade para mim") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu aceito um pedido de amizade feito pelo usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu recuso um pedido de amizade feito por um usuario que nao existe") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu recuso um pedido de amizade feito pelo usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu estou na minha lista de amizades") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu clico para desfazer amizade com o usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu estou na pagina do meu perfil") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu vejo que o usuario {string} nao esta na minha lista de amizades") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu desfaco amizade com um usuario inexistente") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu vejo que o usuario {string} nao esta na minha lista de amizades") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu desfaco amizade com um usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu estou na aba de perfis externos do meu perfil da rede social") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu clico em adicionar novo perfil externo") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("preencho os campos de nome com nome {string} de descricao com {string} e de link com o link {string}") do |string, string2, string3|
  pending # Write code here that turns the phrase above into concrete actions
end

When("clico em salvar perfil externo") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu vejo que o perfil externo com nome {string} com descricao {string} e com o link {string} foi adicionado ao meus perfis externos") do |string, string2, string3|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu possuo um perfil externo com nome {string} com descricao {string} e com o link {string}") do |string, string2, string3|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu clico para remover o perfil externo com nome {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu vejo que o perfil externo com nome {string} com descricao {string} e com o link {string} foi removido da area de perfis externos do meu perfil automaticamente") do |string, string2, string3|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu clico para editar o perfil externo com nome {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("clico no botar de salvar") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu percebo que o perfil externo {string} foi atualizado com a nova descricao e o novo link") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("preencho os campos de descricao com {string} e de link com o link {string} e nao preencho o campo de nome") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

When("preencho os campos de nome com {string} descricao com {string} e nao preencho o campo de link") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu nao preencho nenhum dos campos") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("preencho os campos de nome com {string} com {string} e nao preencho o campo de link") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("o perfil do usuario {string} existe") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu tento editar o perfil externo do perfil do usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu tento excluir o perfil externo do usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("o perfil do usuario {string} eh meu amigo na rede social") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("o perfil do usuario {string} possui um perfil externo com nome {string}") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu acesso o perfil do usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("clico em perfis externos do perfil do usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu clico em visualizar o perfil externo com nome {string} do usuario {string}") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu vejo o perfil externo externo de nome {string} do usuario {string}") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu tento editar o perfil externo do perfil de um usuario que nao existe") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu tento excluir o perfil externo de um usuario que nao existe") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu estou na pagina inicial da rede") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu nao estou logado em meu perfil da rede social") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("o perfil do usuario {string} esta cadastrado") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu tento editar o perfil externo do usuario {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu sou redirecionado para a pagina de login da rede") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu estou na pagina inicial da rede social") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu estou no mural do meu perfil") do
	@link = '/mural/1'
	visit @link
	expect(page).to have_content(@nick)
end

Given("eu clico no botao novo post") do
	click_link 'Novo Post'
	expect(page).to have_content('New Post')
end

When("eu preencho o titulo {string} e o texto {string}") do |titulo, texto|
	fill_in 'post[titulo]', :with=> titulo
	fill_in 'post[texto]', :with=> texto
end

When("eu clico no botao de publicar nova postagem") do
	click_button 'Create Post'
end

Then("eu vejo que o post {string} e o texto {string} foi publicado no meu mural com a devida formatacao") do |titulo, texto|
  expect(page).to have_content('Titulo: ' + titulo)
  expect(page).to have_content('Texto: ' + texto)
  #TODO: depois de implementar o interpretador, verificar se o vloco de codgo aparece
end

Given("a postagem com titulo {string} e o texto {string} existe") do |titulo, texto|
	criarPost(titulo, texto, 1)
	visit @link
	expect(page).to have_content('titulo: ' + titulo)
	expect(page).to have_content('texto: ' + texto)
end

When("eu clico no botao deletar a postagem com o titulo {string}") do |titulo|
	click_link "deleta-#{titulo}"
end

Then("a postagem com o titulo {string} eh deletada e some automaticamente do meu mural") do |titulo|
	expect(page).to have_no_content(titulo)
end

When("eu clico em visualizar o post {string}") do |titulo|
	click_link "mostra-#{titulo}"
end

Then("eu vejo uma tela exibindo o titulo {string}, texto {string} e comentarios do post") do |titulo, texto|
	expect(page).to have_content('Titulo: ' + titulo)
	expect(page).to have_content('Texto: ' + texto)
end

When("eu clico no botao de editar o post {string}") do |titulo|
	click_link "edita-#{titulo}"
	expect(page).to have_content('Editing Post')
end

When("eu preencho os campos do titulo com {string} e o texto com {string}") do |titulo, texto|
	fill_in 'post[titulo]', :with=> titulo
	fill_in 'post[texto]', :with=> texto
end

When("eu clico no botao de atualizar post") do
	click_button 'Update Post'
end

Then("eu vejo que o post {string} foi atualizado para o novo titulo {string} e o novo texto {string}") do |tituloAntigo, tituloNovo, textoNovo|
	expect(page).to have_content('Titulo: ' + tituloNovo)
	expect(page).to have_content('Texto: ' + textoNovo)
end

When("eu clico no botao Publicar sem preencher nenhum campo") do
	click_button 'Create Post'
end

When("eu clico no link {string} da postagem {string}") do |link, postagem|
	#TODO: isso ta meio estranho
	pending
end

Then("eu sou redirecionado para {string}") do |url|
	expect(current_path).to have_content(url)
end

Given("eu aperto em visualizar o post com titulo {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu limpo os campos do titulo e do text") do
	fill_in 'post[titulo]', :with=> ''
	fill_in 'post[texto]', :with=> ''
end

Then("eu vejo que o post {string} possui um player do video {string}") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu preencho o titulo {string}") do |titulo|
	fill_in 'post[titulo]', :with=> titulo
end

When("eu clico no botao de enviar imagem do computador") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu seleciono a imagem {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu clico no botao de selecionar") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu vejo que o post {string} possui a imagem localizada em {string}") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu seleciono o arquivo {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu vejo que o post {string} possui dois links {string} e {string}") do |titulo, link1, link2|
	expect(page).to have_content(titulo)
	expect(page).to have_content(link1)
	expect(page).to have_content(link2)
end

Given("eu estou no perfil do usuario {string}") do |nome|
	deslogar()
	registrarComNome('pt2@email.com', '123456', nome)
	deslogar()
	#TODO: salvar em variavel de instancia?
	login('carlosantonio@o-nucleo.com', 'rails123456')
	visit 'user/2'
	expect(page).to have_content(nome)
end

Given("o mural dele possui o post com titulo {string} e o texto {string}") do |titulo, texto|

	deslogar()
	#TODO: consertar isso aqui tbm
	login('pt2@email.com', '123456')
	criarPost(titulo, texto, 2)
	deslogar()
	login('carlosantonio@o-nucleo.com', 'rails123456')


	visit '/'
	visit "mural/2"
	expect(page).to have_content(titulo)
	expect(page).to have_content(texto)
end

Given("a postagem com titulo {string} e o video {string} existe") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu vejo que o post {string} foi atualizado para o novo titulo {string} e o novo video {string}") do |string, string2, string3|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu estou na pagina inicial") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu clico para registrar") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu estou na pagina de registro") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu preencho os campos de nome com {string}, email com {string}, senha com {string}, confirmacao de senha com {string}, descricao com {string}") do |string, string2, string3, string4, string5|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu clico em registrar usuario") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("eu devo ver que o meu registro foi bem sucedido") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu preencho os campos de nome com {string}, email com {string}, senha com {string}, confirmacao de senha com {string}, descricao com {string}") do |string, string2, string3, string4, string5|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu clico em registrar usuario") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("eu preencho os campos de email com {string}, senha com {string}, confirmacao de senha com {string}, descricao com {string}") do |string, string2, string3, string4|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu preencho os campos de nome com {string}, senha com {string}, confirmacao de senha com {string}, descricao com {string}") do |string, string2, string3, string4|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("Exite um usuario registrado com o email {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu preencho os campos de nome com {string}, email com {string}, descricao com {string}") do |string, string2, string3|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu preencho os campos de nome com {string}, email com {string}, senha com {string}, descricao com {string}") do |string, string2, string3, string4|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu faco o upload de uma foto {string} para o perfil") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("eu faco o upload de um arquivo que nao seja imagem para o perfil") do
  pending # Write code here that turns the phrase above into concrete actions
end
