require 'api_constraints'
Rails.application.routes.draw do
  devise_for :teachers
  devise_for :users
  devise_for :admins
  root 'admins/dashbord#index'
  namespace :admins do

  	resources :schools do
      collection do
        get :import
        post :school_import
      end
    end
  	resources :users  do
      collection do
        get :import
        post :user_import
      end
    end
  	resources :admins do
      collection do
        get :get_profile
        post :update_profile
        post :get_school_by_institution
        get :get_subjects
        get :change_institution_type
      end
    end
  	resources :institutions do
      collection do
        get :import
        post :institute_import
      end
    end
    resources :roles,only:[:index]
    resources :services
    resources :events do
       collection do
        post :get_group_by_school        
      end
      
    end
    resources :subjects do
      collection do
        get :import
        post :subject_import
      end
    end
    resources :school_classes
    resources :merchants
    resources :coupons
    resources :home_works
    resources :exams
    resources :general_configurations
    resources :contacts do
      collection do
        get :import
        post :contact_import
      end
    end
    resources :groups do
      collection do
        get :import
        post :group_import
      end
    end
    resources :assignments do
      collection do
        get :import
        post :assignment_import
        post :get_group_and_student
      end
    end
    # resources :teachers
    resources :exam_results
    resources :schedules
  end

   namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      devise_for :users, :controllers => {
          :registrations => "api/v1/users/registrations",
          :sessions => "api/v1/users/sessions",
          :passwords => "api/v1/users/passwords"
      }
       resource :user, only: [:edit,:show] do
        collection do         
          put 'update_profile'
        end
      end
      get 'log_out' => 'users#log_out'
      resources :home_works
      resources :services
      resources :events
      resources :exams
      resources :subjects,only:[:index]
      resources :groups,only:[:index]
      resources :schedules,only:[:index]
      resources :contacts,only:[:index]
      resources :merchants,only:[:index] do
        member do         
          get 'coupon_from_merchant'
        end
      end
    end
  end
end