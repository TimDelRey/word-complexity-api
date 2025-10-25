Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :complexity_jobs, only: [:show, :create], path: 'complexity-score', param: :job_id
    end
  end
end
