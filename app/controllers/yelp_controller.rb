require 'yelp'

class YelpController < ApplicationController

  def yelp
    # @client = Yelp::Client.new({ consumer_key: "YELP_CONSUMER_KEY",
    #                              consumer_secret: "YELP_CONSUMER_SECRET",
    #                              token: "YELP_TOKEN",
    #                              token_secret: "YELP_TOKEN_SECRET"
    #                              })

    @response = Yelp.client.search("1410 NE Campus Parkway, Seattle WA 98195", { term: "veterinary", limit: 20, sort: 1, radius_filter: 8046.72})
  end

  def search
      address = params[:address]
      @response = Yelp.client.search(address, { term: "veterinary", limit: 20, sort: 1, radius_filter: 8046.72})
      render :yelp
  end

end
