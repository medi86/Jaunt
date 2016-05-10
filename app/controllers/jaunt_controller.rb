class JauntController < ApplicationController
  def home

  end

  def index
    @jaunts = Jaunt.all
  end

  def create
    addresses = params[:jaunt][:addresses].map { |address| Location.new(address: address)}
    Jaunt.create(title: params[:jaunt][:title], locations: addresses)
    redirect_to jaunts_path
  end
end
