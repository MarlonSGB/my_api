Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :tasks, only: [:index, :show, :create]

    end
  end
end
