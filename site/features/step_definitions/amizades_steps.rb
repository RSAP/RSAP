When ("eu tento aceitar uma amizade inexistente") do
	visit '/user/1/pedidosAmizade/aceitar/-1'
end

And("existe o usuario registrado com nome {string}") do |string|
	registrarComNome('matheus@email.com', '123456', string)
	deslogar()
end

When("eu clico para buscar um usuario") do
	visit 'user/2'
	expect(page).to have_content('Buscar um usuario')
	click_link 'Buscar um usuario'
end

And("eu preencho o campo de nome com {string}") do |string|
	fill_in 'search', :with=> string
end

And("eu clico em buscar") do
	find('[name=buscar]').click
end

Then("eu vejo que existe um usuario chamado {string}") do |string|
	expect(page).to have_content(string)
end

And("eu clico para ver o perfil do usuario {string}") do |string|
	click_link 'Visualizar'
end

Then ("eu vejo que o perfil contem o email {string}") do |string|
	expect(page).to have_content(string)
end

Then("eu vejo que minha solicitacao foi enviada") do
	expect(page).to have_content('Pedido de amizade eviado.')
	expect(page).to have_content('Voltar')
end

And("eu e o usuario {string} somos amigos na rede social") do |string|
	visit 'user/2'
	expect(page).to have_content('Meu Perfil')
	visit '2/buscarPessoas/1/pedidoAmizade'
	deslogar()
	login('matheus@email.com', '123456')
	visit '/user/1/buscarPessoas/2'
	visit '/user/1/pedidosAmizade/aceitar/1'
	deslogar()
	login('carlosantonio@o-nucleo.com', 'rails123456')
end

And("eu estou na pagina de perfil do usuario {string}") do |string|
	visit 'user/2'
	expect(page).to have_content('Meu Perfil')
	expect(page).to have_content('Buscar um usuario')
	click_link 'Buscar um usuario'
	fill_in 'search', :with=> string
	find('[name=buscar]').click
	expect(page).to have_content(string)
	click_link 'Visualizar'
end

When ("eu vejo que o usuario {string} ja eh meu amigo") do |string|
	expect(page).to have_no_content("Adicionar aos amigos")
	expect(page).to have_content("Desfazer amizade")
	expect(page).to have_content(string)
end

And("eu envio uma solicitacao de amizade para o usuario {string}") do |string|
	visit '/user/2/buscarPessoas/1/pedidoAmizade'
end

And ("o usuario com nome {string} enviou uma solicitacao de amizade para mim") do |string|
	deslogar()
	login('matheus@email.com', '123456')
	visit '/user/1'
	expect(page).to have_content(string)
	visit '/user/1/buscarPessoas/2/pedidoAmizade'
	deslogar()
	login('carlosantonio@o-nucleo.com', 'rails123456')
end


And ("eu vejo minha lista de amizades") do
	visit '/user/2/listarAmigos'
end

When("eu vejo que o usuario {string} nao esta na lista de amizades") do |string|
	expect(page).to have_no_content(string)
end

And("eu estou na minha lista de solicitacoes de amizade para mim") do
	visit '/user/2/pedidosAmizade'
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
	visit '/user/2/pedidosAmizade'
	expect(page).to have_no_content(string)
end

And("eu clico para desfazer amizade com o usuario {string}") do |string|
	click_link 'Desfazer amizade'
end

Then("eu vejo que o usuario {string} nao esta mais na minha lista de amizades") do |string|
	expect(page).to have_no_content(string)
end

When("eu tento recusar uma amizade inexistente") do
	visit '/user/2/pedidosAmizade/rejeitar/-1'
end

And("o usuario {string} com email {string} e senha {string} existe") do |nome, email, senha|
	registrarComNome(email, senha, nome)
	deslogar()
end

And("o usuario {string} fez um pedido de amizade para o usuario {string}") do |user1, user2|
	login('matheus@email.com', '123456')
	visit '/user/1/buscarPessoas/2/pedidoAmizade'
	deslogar()
end

When("eu tento recusar o pedido de amizade feito por {string} para {string}") do |user1, user2|
	visit '/user/3/pedidosAmizade/rejeitar/1'
end

When("eu tento aceitar o pedido de amizade feito por {string} para {string}") do |user1, user2|
	visit '/user/3/pedidosAmizade/aceitar/1'
end


And("eu estou no meu proprio perfil") do
	visit 'user/1'
end

When("eu solicito amizade a mim mesmo") do
	visit '1/buscarPessoas/1/pedidoAmizade'
end

When("eu envio uma solicitacao para um usuario inexistente") do
	visit '/user/1/buscarPessoas/-1/pedidoAmizade'
end

Then("Eu vejo a pagina do perfil do usuario {string}") do |string|
	expect(page).to have_content(string)
end
