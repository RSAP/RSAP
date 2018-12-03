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
end

Given("eu estou na pagina inicial") do
   visit "/"
end
Given("eu estou na pagina de registro") do
   visit "/users/sign_up"
   expect(page).to have_content('Registro')
end
When("eu clico para registrar") do
   click_link 'Registrar-se'
end

And("eu preencho os campos de nome com {string}, email com {string}, senha com {string}, confirmacao de senha com {string}, descricao com {string}") do |nome, email, senha, confirmacao, descricao|
   fill_in 'user[nome]', :with => nome
   fill_in 'user[email]', :with => email
   fill_in 'user[password]', :with=> senha
   fill_in 'user[password_confirmation]', :with=> confirmacao
   fill_in 'user[descricao]', :with => descricao
end
When("eu clico em registrar usuario") do
   click_button 'Registrar'
end

Then("eu devo ver que o meu registro foi bem sucedido") do
   expect(page).to have_content('Você está logado!!')
end
Then("eu vejo a mensagem de erro {string}") do
   expect(page).to have_content('Nome deve ter pelo menos 5 caracteres')
end
