module LoginHelper

	@nick = ''
	@link = ''
	@oldNick = ''

	def criarPost(titulo, texto, id)
		visit '/'
		visit '/mural/' + id.to_s
		expect(page).to have_content(@nick, wait: 15)
		click_link 'Novo Post'
		expect(page).to have_content('New Post', wait: 15)
		fill_in 'post[titulo]', :with=> titulo
		fill_in 'post[texto]', :with=> texto
		click_button 'Create Post'
		expect(page).to have_content(titulo, wait: 15)
		expect(page).to have_content(texto, wait: 15)
		click_link 'Back'
	end

	def criarPostCat(titulo, texto, id, categoria)
		visit '/'
		visit '/mural/' + id.to_s
		expect(page).to have_content(@nick, wait: 15)
		click_link 'Novo Post'
		expect(page).to have_content('New Post', wait: 15)
		fill_in 'post[titulo]', :with=> titulo
		fill_in 'post[texto]', :with=> texto
		page.find_field('post[categoria]').find("option[value=" + categoria + "]").select_option
		click_button 'Create Post'
		expect(page).to have_content(titulo, wait: 15)
		expect(page).to have_content(texto, wait: 15)
		visit @link
	end


	def registrar(email, senha)
		visit '/'
		visit 'users/sign_up'
		expect(page).to have_content('Registro', wait: 15)
		fill_in 'user[email]', :with=> email
		fill_in 'user[password]', :with=> senha
		fill_in 'user[password_confirmation]', :with=> senha
		fill_in 'user[nome]', :with=> 'Testadeiro'
		fill_in 'user[descricao]', :with=> 'Testando123123'
		click_button 'Registrar'
		expect(page).to have_content('Você está logado!!', wait: 15)
		@oldNick = @nick
		@nick = email.capitalize.split('@').first
	end

	def registrarComNome(email, senha, nome)
		visit '/'
		visit 'users/sign_up'
		expect(page).to have_content('Registro', wait: 15)
		fill_in 'user[email]', :with=> email
		fill_in 'user[password]', :with=> senha
		fill_in 'user[password_confirmation]', :with=> senha
		fill_in 'user[nome]', :with=> nome
		fill_in 'user[descricao]', :with=> 'Testando123123'
		click_button 'Registrar'
		expect(page).to have_content('Você está logado!!', wait: 15)
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
		expect(page).to have_content('Logar', wait: 15)
		fill_in 'user[email]', :with=> email
		fill_in 'user[password]', :with=> senha
		click_button 'Logar'
	end

end

World LoginHelper

Given("eu estou no mural do meu perfil") do
	@link = '/mural/1'
	visit @link
	expect(page).to have_content(@nick, wait: 15)
end

Given("eu clico no botao novo post") do
	click_link 'Novo Post'
	expect(page).to have_content('New Post', wait: 15)
end

When("eu preencho o titulo {string} e o texto {string}") do |titulo, texto|
	fill_in 'post[titulo]', :with=> titulo
	fill_in 'post[texto]', :with=> texto
end

When("eu clico no botao de publicar nova postagem") do
	click_button 'Create Post'
end

Then("eu vejo que o post {string} e o texto {string} foi publicado no meu mural com a devida formatacao") do |titulo, texto|
	expect(page).to have_content(titulo, wait: 15)
	expect(page).to have_content(texto, wait: 15)
	#TODO: depois de implementar o interpretador, verificar se o vloco de codgo aparece
end

Given("a postagem com titulo {string} e o texto {string} existe") do |titulo, texto|
	criarPost(titulo, texto, 1)
	visit @link
	expect(page).to have_content(titulo, wait: 15)
	expect(page).to have_content(texto, wait: 15)
end

When("eu clico no botao deletar a postagem com o titulo {string}") do |titulo|
	click_link "deleta-#{titulo}"
end

Then("a postagem com o titulo {string} eh deletada e some automaticamente do meu mural") do |titulo|
	expect(page).to have_no_content(titulo, wait: 15)
end

When("eu clico em visualizar o post {string}") do |titulo|
	click_link "mostra-#{titulo}"
end

Then("eu vejo uma tela exibindo o titulo {string}, texto {string} e comentarios do post") do |titulo, texto|
	expect(page).to have_content(titulo, wait: 15)
	expect(page).to have_content(texto, wait: 15)
end

When("eu clico no botao de editar o post {string}") do |titulo|
	click_link "edita-#{titulo}"
	expect(page).to have_content('Editing Post', wait: 15)
end

When("eu preencho os campos do titulo com {string} e o texto com {string}") do |titulo, texto|
	fill_in 'post[titulo]', :with=> titulo
	fill_in 'post[texto]', :with=> texto
end

When("eu clico no botao de atualizar post") do
	click_button 'Update Post'
end

Then("eu vejo que o post {string} foi atualizado para o novo titulo {string} e o novo texto {string}") do |_tituloAntigo, tituloNovo, textoNovo|
	expect(page).to have_content(tituloNovo, wait: 15)
	expect(page).to have_content(textoNovo, wait: 15)
end

When("eu clico no botao Publicar sem preencher nenhum campo") do
	click_button 'Create Post'
end

When("eu clico no link {string} da postagem {string}") do |_link, postagem|
	expect(page).to have_content(postagem, wait: 15)
	page.assert_selector('div.linkSimples', minimum: 1)
	#find("a[href='#{link}']").click
	#expect(current_path).to have_content(link, wait: 15)
	#TODO: isso ta meio estranho e talvez nem de pra fazer
end

Then("eu sou redirecionado para {string}") do |url|
	pending # Write code here that turns the phrase above into concrete actions
	expect(current_path).to have_content(url, wait: 15)
end

When("eu limpo os campos do titulo e do text") do
	fill_in 'post[titulo]', :with=> ''
	fill_in 'post[texto]', :with=> ''
end

Then("eu vejo que o post {string} possui um player do video {string}") do |titulo, _video|
	expect(page).to have_content(titulo, wait: 15)
	#TODO: procurar pelo iframe com ocidog do video
	page.assert_selector('div.iframeYT', minimum: 1)
end

When("eu clico na categoria {string}") do |categoria|
	page.find_field('post[categoria]').find("option[value=" + categoria + "]").select_option

end

When("eu preencho o titulo {string}") do |titulo|
	fill_in 'post[titulo]', :with=> titulo
end

When("eu clico no botao de enviar imagem do computador") do
	page.find_field('post[categoria]').find("option[value='Imagem']").select_option
end

When("eu seleciono a imagem {string}") do |imagem|
	attach_file("post[imagem]", Rails.root + "test/fixtures/" + imagem)
end

Then("eu vejo que o post {string} possui a imagem localizada em {string}") do |titulo, _imagem|
	expect(page).to have_content(titulo, wait: 15)
	idImagem = "img#imagemPost"
	visit page.find(idImagem)[:src]
	page.status_code.should be 200
end

When("eu seleciono o arquivo {string}") do |arquivo|
	attach_file("post[imagem]", Rails.root + "test/fixtures/" + arquivo)
end

Then("eu vejo que o post {string} possui dois links {string} e {string}") do |titulo, link1, link2|
	expect(page).to have_content(titulo, wait: 15)
	expect(page).to have_content(link1, wait: 15)
	expect(page).to have_content(link2, wait: 15)
end

Given("eu estou no perfil do usuario {string}") do |nome|
	deslogar()
	registrarComNome('pt2@email.com', '123456', nome)
	deslogar()
	#TODO: salvar em variavel de instancia?
	login('carlosantonio@o-nucleo.com', 'rails123456')
	visit 'user/2'
	expect(page).to have_content(nome, wait: 15)
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
	expect(page).to have_content(titulo, wait: 15)
	expect(page).to have_content(texto, wait: 15)
end

Given("a postagem com titulo {string} e o video {string} existe") do |titulo, video|
	criarPostCat(titulo, video, 1, "Youtube")
	#TODO: procurar por iframe depois
	page.assert_selector('div.iframeYT', minimum: 1)

end

Then("eu vejo que o post {string} foi atualizado para o novo titulo {string} e o novo video {string}") do |_tituloAntigo, tituloNovo, video|
	expect(page).to have_content(tituloNovo, wait: 15)
	page.assert_selector('div.iframeYT', minimum: 1)
end
