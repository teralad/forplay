Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments
    get :recent, on: :collection
    get :popular, on: :collection

    post :follow, on: :member, to: 'post_followers#create'
    delete :unfollow, on: :member, to: 'post_followers#destroy'
  end

  resources :replies
  resources :votes
end
