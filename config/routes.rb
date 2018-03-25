Rails.application.routes.draw do

  devise_for :users
  mount ActionCable.server => '/cable'

  root 'users#new'

  resources :chat_rooms do
    resources :messages
  end

  resources :users
end
