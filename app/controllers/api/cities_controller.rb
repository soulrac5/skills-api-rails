class Api::CitiesController < ApplicationController
  def index
    @country = Country.find(params[:country_id])
    @cities = @country.cities 
  end
end
