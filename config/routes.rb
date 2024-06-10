Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # devise_for :admin_users, ActiveAdmin::Devise.config
  mount Ckeditor::Engine => '/ckeditor' if Gem.loaded_specs.has_key? "ckeditor"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  root to: "trees#index"
  # root to: "homepage#index"
  # root to: "admin/dashboard#index"

  resources :trees, only: [:index, :show]
  resources :items, only: [:index, :show]
  resources :minerva, only: [:index, :show] do
    collection do
      post :enroll
      get :shop_with_us
      get :educators
    end
  end
  resources :crime_reports do
    collection do
      # get :add_community_area
      get :community_areas
      get :add_crime_report
      get :crime_reports
    end
  end

end
