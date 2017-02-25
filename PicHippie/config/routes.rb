Rails.application.routes.draw do
   get 'homepage/index' => 'homepage#index'
   get 'homepage/show/:id' => 'homepage#show', as: 'preview'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
