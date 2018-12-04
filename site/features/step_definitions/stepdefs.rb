
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
		expect(page).to have_content('Voltar')
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
