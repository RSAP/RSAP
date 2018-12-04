def registrarComNomeEDeslogar(email, senha, nome)
	visit '/'
	visit 'users/sign_up'
	expect(page).to have_content('Registro')
	fill_in 'user[email]', :with=> email
	fill_in 'user[password]', :with=> senha
	fill_in 'user[password_confirmation]', :with=> senha
	fill_in 'user[nome]', :with=> nome
	fill_in 'user[descricao]', :with=> 'Eu sou eu. Apenas!'
	click_button 'Registrar'
	expect(page).to have_content('Você está logado!!')
	deslogar()
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

def login(email, senha)
	visit '/'
	visit 'users/sign_in'
	expect(page).to have_content('Logar')
	fill_in 'user[email]', :with=> email
	fill_in 'user[password]', :with=> senha
	click_button 'Logar'
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

Given("eu estou na pagina inicial") do
	visit "/"
end
Given("eu estou na pagina de registro") do
	visit "/users/sign_up"
	expect(page).to have_content('Registro')
end
Given("Exite um usuario registrado com o email {string}") do |email|
	registrarComNomeEDeslogar(email, "senhasenha", "Matheuss")
end

When("eu clico para registrar") do
	click_link 'Registrar-se'
end

#Completo
And("eu preencho os campos de nome com {string}, email com {string}, senha com {string}, confirmacao de senha com {string}, descricao com {string}") do |nome, email, senha, confirmacao, descricao|
	fill_in 'user[nome]', :with => nome
	fill_in 'user[email]', :with => email
	fill_in 'user[password]', :with=> senha
	fill_in 'user[password_confirmation]', :with=> confirmacao
	fill_in 'user[descricao]', :with => descricao
end
#Nome em branco
And("eu preencho os campos de email com {string}, senha com {string}, confirmacao de senha com {string}, descricao com {string}") do |email, senha, confirmacao, descricao|
	fill_in 'user[email]', :with => email
	fill_in 'user[password]', :with=> senha
	fill_in 'user[password_confirmation]', :with=> confirmacao
	fill_in 'user[descricao]', :with => descricao
end
#Email em branco
And("eu preencho os campos de nome com {string}, senha com {string}, confirmacao de senha com {string}, descricao com {string}") do |nome, senha, confirmacao, descricao|
	fill_in 'user[nome]', :with => nome
	fill_in 'user[password]', :with=> senha
	fill_in 'user[password_confirmation]', :with=> confirmacao
	fill_in 'user[descricao]', :with => descricao
end
#Confirmacao em branco
When("eu preencho os campos de nome com {string}, email com {string}, senha com {string}, descricao com {string}") do |nome, email, senha, descricao|
	fill_in 'user[nome]', :with => nome
	fill_in 'user[email]', :with => email
	fill_in 'user[password]', :with=> senha
	fill_in 'user[descricao]', :with => descricao
end
#Confirmacao e senha em branco
When("eu preencho os campos de nome com {string}, email com {string}, descricao com {string}") do |nome, email, descricao|
	fill_in 'user[nome]', :with => nome
	fill_in 'user[email]', :with => email
	fill_in 'user[descricao]', :with => descricao
end

#Upload de foto
And("eu faco o upload de uma foto {string} para o perfil") do |nome|
	attach_file("user[avatar]", Rails.root + "test/fixtures" + nome)
end
#upload de arquivo invalido
And("eu faco o upload de um arquivo que nao seja imagem para o perfil") do
	attach_file("user[avatar]", Rails.root + "test/fixtures/foto.txt")
end

When("eu clico em registrar usuario") do
	click_button 'Registrar'
end

Then("eu devo ver que o meu registro foi bem sucedido") do
	expect(page).to have_content('Você está logado!!')
end

When ("eu tento aceitar uma amizade inexistente") do
	visit '/user/1/pedidosAmizade/aceitar/-1'
end


And("existe um usuario registrado com nome {string}") do |string|
	deslogar()
	registrarComNome('matheus@email.com', '123456', string)
	deslogar()
	#TODO: salvar em variavel de instancia?
	login('carlosantonio@o-nucleo.com', 'rails123456')
	visit 'user/1'
	expect(page).to have_content('Meu Perfil')
end

Given ("eu estou logado no meu perfil da rede social com o email {string} e senha {string}") do |email, senha|
	registrar(email, senha)
end

When("eu clico para buscar um usuario") do
	expect(page).to have_content('Buscar um usuario')
	click_link 'Buscar um usuario'
end

And("eu preencho o campo de nome com {string}") do |string|
	fill_in 'search', :with=> string
end

And("eu clico em buscar") do
	find('[name=buscar]').click
end

Then("eu devo ver que existe um usuario chamado {string}") do |string|
	expect(page).to have_content(string)
end

And("eu vejo que existe um usuario chamado {string}") do |string|
	expect(page).to have_content(string)
end

And("eu clico para ver o perfil do usuario {string}") do |string|
	click_link 'Visualizar'
end

Then("Eu vejo a pagina do perfil do usuario {string}") do |string|
	expect(page).to have_content(string)
end

Then ("eu vejo que o perfil contem o email {string}") do |string|
	expect(page).to have_content(string)
end

And ("eu solicito amizade ao usuario {string}") do |string|
	visit '/user/1/buscarPessoas/2/pedidoAmizade'
end

Then("eu vejo que minha solicitacao foi enviada") do
	expect(page).to have_content('Pedido de amizade eviado.')
	expect(page).to have_content('Voltar')
end

And("eu estou na pagina de perfil do usuario {string}") do |string|
	deslogar()
	registrarComNome('matheus@email.com', '123456', string)
	deslogar()
	#TODO: salvar em variavel de instancia?
	login('carlosantonio@o-nucleo.com', 'rails123456')
	visit 'user/1'
	expect(page).to have_content('Meu Perfil')
	expect(page).to have_content('Buscar um usuario')
	click_link 'Buscar um usuario'
	fill_in 'search', :with=> string
	find('[name=buscar]').click
	expect(page).to have_content(string)
	click_link 'Visualizar'
end

When("eu envio uma solicitacao para um usuario inexistente") do
	visit '-1/pedidoAmizade'
end

Then ("eu vejo a mensagem de erro {string}") do |string|
	expect(page).to have_content(string)
end

And("eu estou no meu proprio perfil") do
	visit 'user/1'
end

When("eu solicito amizade a mim mesmo") do
	visit '1/buscarPessoas/1/pedidoAmizade'
end

When ("eu vejo que o usuario {string} ja eh meu amigo") do |string|
	visit '/user/1/buscarPessoas/2'
	click_link 'Adicionar aos amigos'
	deslogar()
	login('matheus@email.com', '123456')
	visit '/user/2/buscarPessoas/1'
	click_link 'Aceitar'
	deslogar()
	login('carlosantonio@o-nucleo.com', 'rails123456')
	visit '/user/1/buscarPessoas/2'
	expect(page).to have_no_content("Adicionar aos amigos")
	expect(page).to have_content("Desfazer amizade")
	expect(page).to have_content(string)
end

And("eu envio uma solicitacao de amizade para o usuario {string}") do |string|
	visit '/user/1/buscarPessoas/2/pedidoAmizade'
end

And ("eu vejo minha lista de amizades") do
	visit '/user/1/listarAmigos'
end

When("eu vejo que o usuario {string} nao esta na lista de amizades") do |string|
	deslogar()
	registrarComNome('matheus@email.com', '123456', string)
	visit '/user/2/buscarPessoas/1/pedidoAmizade'
	deslogar()
	login('carlosantonio@o-nucleo.com', 'rails123456')
	visit '/user/1/listarAmigos'
	expect(page).to have_no_content(string)
end

And("eu estou na minha lista de solicitacoes de amizade para mim") do
	visit '/user/1/pedidosAmizade'
end

And ("eu vejo que o usuario {string} esta na lista de solicitacoes de amizade") do |string|
	expect(page).to have_content(string)
	expect(page).to have_content('Aceitar')
	expect(page).to have_content('Recusar')
end

And("eu aceito a solicitacao do usuario {string}") do |string|
	click_link 'Aceitar'
end

Then ("eu vejo que o usuario {string} esta na lista de amizades") do |string|
	expect(page).to have_content(string)
	expect(page).to have_content('Visualizar')
end

And ("eu recuso a solicitacao do usuario {string}") do |string|
	click_link 'Recusar'
end

Then("eu vejo que o usuario {string} nao esta na lista de solicitacoes de amizade para mim") do |string|
	visit '/user/1/pedidosAmizade'
	expect(page).to have_no_content(string)
end

When ("eu vejo que o usuario {string} esta na lista de solicitacoes de amizade para mim") do |string|
	deslogar()
	registrarComNome('matheus@email.com', '123456', string)
	visit '/user/2/buscarPessoas/1/pedidoAmizade'
	deslogar()
	login('carlosantonio@o-nucleo.com', 'rails123456')
	visit '/user/1/pedidosAmizade'
	expect(page).to have_content(string)
end

When ("eu clico para visualizar o perfil do usuario {string}") do |string|
	deslogar()
	registrarComNome('matheus@email.com', '123456', string)
	visit '/user/2/buscarPessoas/1/pedidoAmizade'
	deslogar()
	login('carlosantonio@o-nucleo.com', 'rails123456')
	visit '/user/1/pedidosAmizade'
	click_link 'Aceitar'
	visit '/user/1/listarAmigos'
	click_link 'Visualizar'
	expect(page).to have_content('Desfazer amizade')
end

And("eu clico para desfazer amizade com o usuario {string}") do |string|
	click_link 'Desfazer amizade'
end

Then("eu vejo que o usuario {string} nao esta mais na minha lista de amizades") do |string|
	expect(page).to have_no_content(string)
end

When("eu tento recusar uma amizade inexistente") do
	visit '/user/1/pedidosAmizade/rejeitar/-1'
end

And("o usuario {string} com email {string} e senha {string} existe") do |nome, email, senha|
	deslogar()
	registrarComNome(email, senha, nome)
end

And("o usuario {string} fez um pedido de amizade para o usuario {string}") do |user1, user2|
	visit '/user/3/buscarPessoas/2/pedidoAmizade'
	deslogar()
end

When("eu tento recusar o pedido de amizade feito por {string} para {string}") do |user1, user2|
	login('carlosantonio@o-nucleo.com', 'rails123456')
	visit '/user/1/pedidosAmizade/rejeitar/1'
end

When("eu tento aceitar o pedido de amizade feito por {string} para {string}") do |user1, user2|
	login('carlosantonio@o-nucleo.com', 'rails123456')
	visit '/user/1/pedidosAmizade/aceitar/1'
end
