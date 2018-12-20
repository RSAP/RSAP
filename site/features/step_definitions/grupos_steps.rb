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
	expect(page).to have_content('Logar', wait: 15)
	fill_in 'user[email]', :with=> email
	fill_in 'user[password]', :with=> senha
	click_button 'Logar'
end


Given("eu estou logado no sistema com nome {string}, email {string} e senha {string}") do |nome, email, senha|
	registrarComNome(email, senha, nome)
end

Given("eu estou na pagina do meu perfil") do
	visit 'user/1'
	expect(page).to have_content('Meu Perfil')
end

When ("eu clico no botao Criar Grupo") do
	click_link "Criar Grupo"
end

Given("eu preencho o campo nome com {string} e descricao {string}") do |nome, descricao|
	fill_in 'grupo[nome]', :with=> nome
	fill_in 'grupo[descricao]', :with=> descricao
end

And ("eu clico no botao Create Grupo") do
	click_button 'Create Grupo'
end

Then("eu vejo que o grupo com nome {string} e descricao {string} foi criado") do |nome, descricao|
	expect(page).to have_content(nome)
	expect(page).to have_content(descricao)
end

And ("eu crio um grupo com nome {string} e descricao {string}") do |nome, descricao|
	visit 'grupos/new'
	fill_in 'grupo[nome]', :with=> nome
	fill_in 'grupo[descricao]', :with=> descricao
	click_button 'Create Grupo'
end

When("eu clico em Editar") do
	click_link 'Editar'
end

And("eu estou na pagina principal do grupo de nome {string}") do |_nome|
	visit 'grupos/1'
end

And("eu clico em Atualizar!") do
	click_button 'Atualizar!'
end

Then("eu vejo que o grupo agora tem nome {string} e descricao {string}") do |nome, descricao|
	expect(page).to have_content(nome)
	expect(page).to have_content(descricao)
end

And("eu nao preencho o campo nome e preencho o campo descricao com {string}") do |descricao|
	fill_in 'grupo[descricao]', :with=> descricao
end

And("eu clico para ver o grupo") do
	click_link 'Ver'
end

When("eu clico em Apagar") do
	click_link 'Apagar'
end

And("eu confirmo que quero apagar o grupo") do
	page.evaluate_script('window.confirm = function() { return true; }')
end

Then("eu vejo que o grupo foi apagado com sucesso") do
	expect(page).to have_content("sucesso")
end


When("eu clico no botao Buscar grupo") do
	click_link 'Buscar grupo'
end

And("eu preencho o campo de busca com nome {string}") do |nome|
	fill_in 'search', :with=> nome
end

And("eu clico em Buscar") do
	click_button 'Buscar'
end

Then("eu vejo o grupo que criei com nome {string} e descricao {string}") do |nome, descricao|
	expect(page).to have_content(nome)
	expect(page).to have_content(descricao)
end

And("eu participo de um grupo com nome {string}") do |nome|
	visit 'grupos/new'
	fill_in 'grupo[nome]', :with=> nome
	fill_in 'grupo[descricao]', :with=> "descricao do grupo"
	click_button 'Create Grupo'
end

When("eu clico no botao Meus grupos") do
	click_link 'Meus grupos'
end

Then("eu vejo o grupo com nome {string}") do |nome|
	expect(page).to have_content(nome)
end

And("o usuario com nome {string} e email {string} existe") do |nome, email|
	deslogar()
	registrarComNome(email, "asdasd", nome)
end

And("o usuario com nome {string} e email {string} envia pela primeira vez a solicitacao de entrada no grupo de nome {string}") do |_a, _as, _asd|
	visit '/grupos/1'
	click_link 'Quero entrar'
end

And("eu estou logado com email {string} e senha {string}") do |email, senha|
	deslogar()
	login(email, senha)
end

And("eu estou na pagina de solicitacoes do grupo de nome {string}") do |nome|
	visit '/grupos/solicitacoes/1'
end

When("eu clico para aceitar a solicitacao do usuario de nome {string}") do |_nome|
	click_link "Aceitar"
end

Then("eu nao vejo que a solicitacao nao existe mais") do
	visit '/grupos/solicitacoes/1'
	expect(page).to have_no_content("Aceitar")
end

And("eu vejo que o usuario com nick {string} faz parte do grupo") do |nome|
	visit '/grupos/1/membros'
	expect(page).to have_content(nome)
end

#page.evaluate_script('window.confirm = function() { return true; }')

And("eu preencho o campo nome com {string} e nao preencho o campo descricao") do |nome|
	fill_in 'grupo[nome]', :with=> nome
end
