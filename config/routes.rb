Rails.application.routes.draw do
    # devise_for :users
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


    # We'll scope our Devise routes under /users for clarity
    # And we'll tell Devise to use our custom controllers
    devise_for :users,
               path: "", # No '/users' prefix for the path itself (e.g. /login not /users/login)
               path_names: {
                 sign_in: "login",
                 sign_out: "logout",
                 registration: "signup"
               },
               controllers: {
                 sessions: "users/sessions",
                 registrations: "users/registrations"
               }
  # ... your other API routes ...

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
