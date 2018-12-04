Rails.application.routes.draw do
  root to: "pages#home"


  #Exemplo:
  #match 'diretorio na url' => 'controller e funcao', via: :get ou post

  match 'user/:id' => 'user#show', via: :get

  #provisOrio
  match 'erro' => "user#erro", via: :get

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

<<<<<<< HEAD
=======
	match 'home' => 'user#home', via: :get
	match 'mural/:id' => 'user#mural', via: :get

	resources :posts, :except => [:index]

>>>>>>> e5c91a3a22174a992af4d8cf249b56e8cd50e7d1

end
