require 'yelp'
require 'json'

class YelpController < ApplicationController

  def yelp
    @address      = "1410 NE Campus Parkway, Seattle WA 98195"
    @vets         = Yelp.client.search(@address, {category_filter: 'vet', limit: 10, sort: 1, radius_filter: 8046.72})
    @pet_services = Yelp.client.search(@address, {category_filter: 'dogwalkers,pet_sitting,groomer,pet_training', limit: 10, sort: 1, radius_filter: 8046.72})
    @pet_stores   = Yelp.client.search(@address, {category_filter: 'petstore', limit: 10, sort: 1, radius_filter: 8046.72})
    @parks        = Yelp.client.search(@address, {category_filter: 'parks,dog_parks,beaches', limit: 10, sort: 1, radius_filter: 8046.72})
      # take total yelp score of all vets and create a pet score based off the yelp score
      # so for example a score of 4.5 would be a pet score of 25 out of overall score of 100
    yelp_score = YelpScore.new(
    :vets     => @vets.businesses,
    :services => @pet_services.businesses,
      :stores   => @pet_stores.businesses,
      :parks    => @parks.businesses,
    )


    yelp_score.overall_score

    render json: yelp_score.overall_score

  end









end
