H1movies::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  match 'peliculas/estrenos' => 'peliculas#estrenos'
  match 'peliculas/cartelera' => 'peliculas#cartelera'
  match 'peliculas/insertall' => 'peliculas#insertAll'  
  match 'peliculas/insertestrenos' => 'peliculas#insertEstrenos'    
  match 'peliculas/:pelicula_id' => 'peliculas#get' 


  match 'cines' => 'cines#all'
  match 'cines/insertall' => 'cines#insertAll'
  match 'cines/findnear' => 'cines#findNear'
  match 'cines/:cine_id' => 'cines#get'  
  match 'cines/:cine_id/:movie_id' => 'cines#get'  
  match 'cines/whereami/:latitud/:longitud' => 'cines#whereAmI', :constraints => { :latitud => /[\-0-9\.]+/, :longitud => /[\-0-9\.]+/ }    
  match 'cines/findnear/:latitud/:longitud' => 'cines#findNear', :constraints => { :latitud => /[\-0-9\.]+/, :longitud => /[\-0-9\.]+/ }      

  
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #resources :cines

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
