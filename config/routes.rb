BtownEvents::Application.routes.draw do

  # mobile
  MOBILE_USER_AGENTS = 'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
    'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
    'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
    'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
    'webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|' +
    'mobile'

  root :to => 'events#date', :constraints => {:user_agent => Regexp.new(MOBILE_USER_AGENTS, true)}
  match '/date/:year/:month/:day' => 'events#date', 
    :constraints => {:user_agent => Regexp.new(MOBILE_USER_AGENTS, true)}

  # web
  root :to => 'events#index'

  match 'sort' => 'categories#sort'
  resources :categories, :only => [:index, :show]

  match '/increment' => 'events#increment'
  match '/cat_increment' => 'categories#increment'
  resources :events, :only => [:index, :show]

  match '/places' => 'facilities#index', :as => "facilities", :controller => :facility
  match '/places/:id' => 'facilities#show', :as => "facility", :controller => :facility

  #match '/app.manifest' => Rails::Offline
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
