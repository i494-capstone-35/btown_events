BtownEvents::Application.routes.draw do
  ################
  #    mobile    #
  ################
  MOBILE_USER_AGENTS = 'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
    'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|'                    +
    'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|'                    +
    'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|'                    +
    'webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|'                       +
    'mobile'

  root :to => 'events#date', :constraints => {:user_agent => Regexp.new(MOBILE_USER_AGENTS, true)}

  match '/date/:year/:month/:day' => 'events#date',
        :constraints              => {:user_agent => Regexp.new(MOBILE_USER_AGENTS, true)}

  ################
  #    desktop   #
  ################
  root :to => 'events#index'

  match '/categories_images'   => 'categories#images'
  resources :categories, :only => [:index, :show]

  match '/increment'       => 'events#increment'
  match '/cat_increment'   => 'categories#increment'
  resources :events, :only => [:index, :show]

  match '/places'        => 'facilities#index', :as => "facilities", :controller => :facility
  match '/places_images' => 'facilities#images'
  match '/places/:id'    => 'facilities#show', :as  => "facility", :controller   => :facility
end
