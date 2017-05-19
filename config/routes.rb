Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: :callbacks,
    sessions: "sessions"}
  root "education/home#index"
  namespace :education do
    namespace :management do
      resources :permissions, only: :create
      resources :abouts, only: [:index, :update]
      resources :feedbacks, only: [:index, :destroy]
      resources :learning_programs, only: [:index, :update]
      resources :techniques
      resources :group_users, only: [:create, :index]
      resources :users, only: [:index, :update, :create]
      resources :categories, except: [:show, :new, :edit]
      resources :course_registers, only: [:index, :update]
      resources :trainings
      resources :courses
      resources :projects
      root "users#index"
    end
    root "home#index"
    resources :projects do
      resources :comments
      resources :rates, only: :create
    end
    resources :trainers, only: :index
    resources :trainings, only: [:index, :show]
    resources :techniques
    resources :feedbacks, only: [:new, :create]
    resources :courses, only: [:index, :show]
    resources :trainings, only: :index
    resources :posts do
      resources :comment_posts, except: [:index, :show]
      resources :rates, only: :create
    end
    resources :course_members, only: [:create, :destroy]
    resources :users, only: :show
    resources :images
    resources :project_members, only: [:create, :destroy]
    resources :about, only: :index
    resources :recruitments do
      resources :comment_recruitments, except: [:index, :show]
      resources :rates, only: :create
    end
  end

  resources :users
  resources :user_avatars, only: :create
  resource :user_avatars, only: :update
  resources :user_covers, only: :create
  resource :user_covers, only: :update
  resources :info_users, only: [:create, :update]
  resources :course_registers, only: [:new, :create, :show]
end
