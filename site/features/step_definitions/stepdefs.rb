def registrarComNome(email, senha, nome)
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
	registrarComNome(email, "senhasenha", "Matheuss")
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
Then("eu vejo a mensagem de erro {string}") do |msg|
   expect(page).to have_content(msg)
end
