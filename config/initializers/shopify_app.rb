ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = "30f92497a6017e9b0f4015b7bded903c"
  config.secret = "7405e8b2fe8b8f7506fa134ccf6b6dd7"
  config.scope = "read_orders, read_products"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
end
