match 'grupos/' => 'grupo#index', via: :get
match 'grupos/new/' => 'grupo#new', via: :get
match 'grupos/:id/edit/' => 'grupo#edit', via: :get
match 'grupos/:id/' => 'grupo#show', via: :get

match 'grupos/' => 'grupo#create', via: :post
