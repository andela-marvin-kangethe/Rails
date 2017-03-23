Rails.application.routes.draw do
   get 'art/index' => 'homepage#index'
   get 'art/show/:id' => 'homepage#show', as: 'preview'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
