Rails.application.routes.draw do
  root to: "pages#home"


  #Exemplo:
  #match 'diretorio na url' => 'controller e funcao', via: :get ou post

  match 'user/show/:id' => 'user#show', via: :get

  match 'user/edit/:id' => 'devise/registrations#edit', via: :get

  #provisOrio
  match 'erro' => "user#erro", via: :get

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
