class HomeController < ShopifyApp::AuthenticatedController
	skip_before_action :verify_authenticity_token, :only => [:webhookCreateaorder]
  def index
  #	Orderl.delete_all
  	count = ShopifyAPI::Order.count({:status=>"any"})
  	#puts count.count
  if Orderl.count() < ShopifyAPI::Order.count()
  	init_webhooks
  	puts "_________________________ HI _______________________"
  	#fetch_all_orders()
  end
  pages = count / 250
  if pages == 0
  	pages = 1
  elsif pages > 10
  	pages = 10
  end

@orders = []
   1.upto(pages) do |page|
	  @orders1 = ShopifyAPI::Order.find(:all, params: {limit: 250, page: page, status: 'any', :order => "created_at DESC"})
	 @orders = @orders + @orders1

	 end
	#@orders = []
	#Orderl.find_each do |ol|

	#	@orders << JSON.parse(ol.order,object_class: OpenStruct)
		
	#end
    # @uri = URI.parse("https://#{@shop_session.url}/admin/orders.json")
  end
 


  def fetch_all_orders

  	lastOrder = Orderl.last
  	lastOrderObj = JSON.parse(lastOrder.order,object_class: OpenStruct)
    totalCount = ShopifyAPI::Order.count()
  	remainingCount = ShopifyAPI::Order.count({:since_id => lastOrderObj.id})
  	count = totalCount - remainingCount
	pages = count / 250
	totalPages = totalCount / 250
	if pages == 0
		pages = 1
	end
	order = nil
	puts "count = "+count.to_s+" pages = "+pages.to_s+", totalPages = "+totalPages.to_s
	pages.upto(totalPages) do |page|
	  @orders1 = ShopifyAPI::Order.find(:all, params: {limit: 250, page: page, status: 'any', :order => "created_at DESC"})
	  #order = orders.find { |o| o.order_number == DESIRED_NUMBER }
	  
    	
    
	   
		@orders1.each do |o| 
			@orderl = Orderl.where(order_id: o.id)
			if @orderl != nil
				puts @orderl
			else

			    @orderl = Orderl.new()
			    @orderl.order_id = o.id
				@orderl.order = o.to_json
				@orderl.save
			end
		end
	end

  end


def init_webhooks

   

      webhook = ShopifyAPI::Webhook.create(:format => "json", :topic => "orders/create", :address => "https://3eee1c3c.ngrok.io/custom/webhookCreateaorder")
webhookUpdateOrder = ShopifyAPI::Webhook.create(:format => "json", :topic => "orders/updated", :address => "https://3eee1c3c.ngrok.io/custom/webhookUpdateOrder")
ShopifyAPI::Webhook.create(:format => "json", :topic => "orders/fulfilled", :address => "https://3eee1c3c.ngrok.io/custom/webhookUpdateOrder")
ShopifyAPI::Webhook.create(:format => "json", :topic => "orders/paid", :address => "https://3eee1c3c.ngrok.io/custom/webhookUpdateOrder")
ShopifyAPI::Webhook.create(:format => "json", :topic => "orders/partially_fulfilled", :address => "https://3eee1c3c.ngrok.io/custom/webhookUpdateOrder")
   

    # raise "Webhook invalid: #{webhook.errors}" unless webhook.valid?

 	
end



def webhookCreateaorder
  @orderl = Orderl.new()
		    @orderl.order_id = params[:id]
			@orderl.order = params.to_json
			@orderl.save

 respond_to do |format|
    format.json { head :ok }
  end
end
end
