

match '/grupos/buscar/' => 'grupo#buscarGrupoNome',  via: :get
match '/grupos/buscar/' => 'grupo#buscarGrupoNome', :as => :grupo_busca, via: :post
match '/grupos/:id/membros' => 'grupo#verMembros', :as => :membros_grupo, via: :get
match 'grupos/:id/deletar/' => 'grupo#destroy', :as => :destroy_grupo, via: :get
match 'grupos/:id/edit/' => 'grupo#update', :as => :att_grupo, via: :post

match "grupos/" => "grupo#index", :as => :list, via: :get
match "grupos/new/" => "grupo#new", via: :get
match "grupos/:id/edit/" => "grupo#edit", via: :get
match "grupos/:id/" => "grupo#show", :as => :grupo_ver, via: :get

match "grupos/sair/:idGrupo/" => "grupo#sair", via: :get

match "grupos/" => "grupo#create", via: :post

match "grupos/:idGrupo/addModerador/:idNovoModerador" => "grupo#atribuirNovoModerador", via: :get

match "grupos/:idGrupo/removerModeracao/:idModerador" => "grupo#removerModeracao", via: :get

match "gruposDe/:id" => "grupo#gruposDe", via: :get
