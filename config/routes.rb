Rails.application.routes.draw do

  resources :metrics, only: %i[index create] do
    member do
      get :averages
    end
    resources :metric_records, only: [:create]
  end

end
