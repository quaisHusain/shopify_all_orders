Rails.application.routes.draw do
  get 'custom/webhookCreateaorder'

  root :to => 'home#index'

  get 'get_orders' => 'order_controller#get_orders'
  post '/home/webhookCreateaorder', :to => 'home#webhookCreateaorder'
  post '/custom/webhookCreateaorder', :to => 'custom#webhookCreateaorder'
  post '/custom/webhookUpdateOrder', :to => 'custom#webhookUpdateOrder'
  
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
