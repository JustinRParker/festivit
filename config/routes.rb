Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users

  resources :admins, controller: 'users', only: [:new, :create], type: 'Admin'
  resources :volunteers, controller: 'users', only: [:new, :create], type: 'Volunteer'
  resources :applicants, controller: 'users', only: [:show], type: 'Applicant'

  resources :participants, only: [:new, :create, :edit, :show, :index] do
    resources :submissions, except: :index
    collection {
	    get :customers
      get :import
      post :import
    }
  end


  get 'submissions', to: 'submissions#index'
  post 'approve/:id', to: 'submissions#approve'

  get 'tickets/import', to: "tickets#import", :as => :import_tickets
  post 'tickets/import', to: "tickets#import"

  get 'fests/import', to: "fests#import", :as => :import_fests
  post 'fests/import', to: "fests#import"

  get 'ticket_types/import', to: "ticket_types#import", :as => :import_ticket_types
  post 'ticket_types/import', to: "ticket_types#import"

  resources :tickets do
    collection do
      put :pick_up
      post :import
    end
  end

  resources :ticket_types do
    collection do
      post :import
    end
  end

  resources :fests do
    collection do
      post :import
    end
  end
end
