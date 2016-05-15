class JauntController < ApplicationController

  before_action :require_login, only: [:new]
  def home
  end

  def index
    @jaunts = Jaunt.all
  end

  def new
  end

  def create
    addresses = params[:jaunt][:addresses].map do |pos, loc|
     Location.new(address: loc[:address], description: loc[:description], position: pos, latitude: loc[:coordinates][:lat], longitude: loc[:coordinates][:lng])
    end

    flash[:success] = "New jaunt! Thank you!"

    render json: current_user.jaunts.create(title: params[:jaunt][:jaunt_title], description: params[:jaunt][:jaunt_description], locations: addresses)
  end

  def show
    @jaunt = Jaunt.find_by_id(params[:id])
    gon.jaunt = @jaunt.locations[0]
  end

  def destroy
    jaunt = Jaunt.find(params[:id])
    jaunt.destroy
    redirect_to jaunts_path
  end
end
