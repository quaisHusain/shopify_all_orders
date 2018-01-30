Rails.application.config.middleware.use OmniAuth::Builder do
  provider :shopify,
           ShopifyApp.configuration.api_key,
           ShopifyApp.configuration.secret,
           scope: ShopifyApp.configuration.scope,
           setup: lambda { |env|
             strategy = env['omniauth.strategy']
             redirect_uri = 'https://3eee1c3c.ngrok.io/auth/shopify/callback​'
             shopify_auth_params = strategy.session['shopify.omniauth_params']&.with_indifferent_access

             shop = if shopify_auth_params.present?
               "https://#{shopify_auth_params[:shop]}"
             else
               ''
             end

             strategy.options[:client_options][:site] = shop
           }

end
