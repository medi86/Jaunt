class JauntController < ApplicationController
  def home
  end

  def index
    @jaunts = Jaunt.all
  end

  def create
    addresses = params[:jaunt][:addresses].map do |pos, loc|
    Location.new(address: loc[:address], description: loc[:description], position: pos)
    end

    Jaunt.create(title: params[:jaunt][:jaunt_title], description: params[:jaunt][:jaunt_description], locations: addresses)
  end

  def show
    @jaunt = Jaunt.find_by_id(params[:id])
  end
end
