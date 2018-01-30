class CustomController < ApplicationController
  def webhookCreateaorder
  	 @orderl = Orderl.new()
		    @orderl.order_id = params[:id]
			@orderl.order = params.to_json
			@orderl.save

 respond_to do |format|
    format.json { head :ok }
  end
  end


def webhookUpdateOrder

	puts "____________________________ order id "+params[:id].to_s
  	 @orderl = Orderl.where(order_id: params[:id])
		    #@orderl.order_id = params[:id]
			puts @orderl.to_json
			@orderl.order = params.to_json
			@orderl.save

 respond_to do |format|
    format.json { head :ok }
  end
  end

end
