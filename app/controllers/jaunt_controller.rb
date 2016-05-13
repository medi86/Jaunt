class JauntController < ApplicationController
  def home
  end

  def index
    @jaunts = Jaunt.all
  end

  def new
  end

  def create
    addresses = params[:jaunt][:addresses].map do |pos, loc|
     latlng = JSON.dump(loc[:coordinates])
     Location.new(address: loc[:address], description: loc[:description], position: pos, coordinates: latlng)
    end

    render json: current_user.jaunts.create(title: params[:jaunt][:jaunt_title], description: params[:jaunt][:jaunt_description], locations: addresses)
  end

  def show
    @jaunt = Jaunt.find_by_id(params[:id])
    gon.jaunt = JSON.parse(@jaunt.locations[0].coordinates)
  end
end
