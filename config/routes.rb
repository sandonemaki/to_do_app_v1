Rails.application.routes.draw do
  get 'tasks/index'
  get "tasks/index" => "tasks#index"

  root "home#top"
end
