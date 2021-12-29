Rails.application.routes.draw do
  get "tasks/index" => "tasks#index"
  get "tasks/new" => "tasks#new"
  post "tasks/create" => "tasks#create"
end
