Rails.application.routes.draw do

	match '/perfil_externo/destroy/:id' => 'perfil_externos#destroy', :as => :destroy_perfil, via: :patch

    match '/perfil_externo/:id/atualizar' => 'perfil_externos#edit', via: :get

	match '/perfil_externo/:id/atualizar/sucesso' => 'perfil_externos#update', :as => :update_perfil_externos, via: :post

	resources :perfil_externos
	root to: "pages#home"


	#Exemplo:
	#match 'diretorio na url' => 'controller e funcao', via: :get ou post

	match 'user/show/:id' => 'user#show', via: :get

	match 'users/' => 'user#sendToHome', via: :get

	#provisOrio
	match 'erro' => "user#erro", via: :get

	match '/perfil_externo/' => 'perfil_externos#show', via: :get

	match 'user/buscarPessoas/:id/perfil_externo' => 'perfil_externos#friend_perfil_externo', via: :get

	match 'user/:id/pedidosAmizade/aceitar/:request_id' => 'friendships#update', via: :get

	match 'user/:id/pedidosAmizade/rejeitar/:request_id' => 'friendships#destroy', via: :get

	match 'user/:id/buscarPessoas/:friend_id/pedidoAmizade' => 'friendships#create', via: :get

	match 'user/:id/pedidosAmizade' => 'user#list', via: :get

	match 'user/:id/buscarPessoas' => 'user#index', :as => :user, via: :post

	match 'user/:id/buscarPessoas' => 'user#index', via: :get

	match 'user/:id/listarAmigos' => 'user#listFriends', via: :get

	match 'user/:id/buscarPessoas/:idUser' => 'user#viewUser', via: :get

	match 'user/:id' => 'user#show', via: :get

	devise_for :users
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	match 'home' => 'user#home', via: :get
	match 'mural/:id' => 'user#mural', via: :get

	resources :posts, :except => [:index]

	#Uso dinamico de arquivos de rotas
	def draw(rotas)
		instance_eval(File.read(Rails.root.join("config/roteamento/#{rotas}.rb")))
	end

	draw :rotas_grupo


end
