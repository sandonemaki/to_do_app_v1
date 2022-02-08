Rails.application.routes.draw do
  # get "tasks/index" => "tasks#index"
  get "tasks/new" => "tasks#new"
  post "tasks/create" => "tasks#create"
  get "tasks/:id/edit" => "tasks#edit"
  post "tasks/:id/update" => "tasks#update"
  post "tasks/:id/destroy" => "tasks#destroy"

  resources :tasks do
    put :done, on: :member
    put :undone, on: :member
    get :fin_index, on: :collection
  end

  root to: "tasks#index"
end
