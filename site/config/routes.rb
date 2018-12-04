Rails.application.routes.draw do

  root to: "pages#home"


  #Exemplo:
  #match 'diretorio na url' => 'controller e funcao', via: :get ou post

  match 'user/show/:id' => 'user#show', via: :get

  match 'users/' => 'user#sendToHome', via: :get

  #provisOrio
  match 'erro' => "user#erro", via: :get

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


end
