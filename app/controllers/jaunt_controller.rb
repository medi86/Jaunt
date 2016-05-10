class JauntController < ApplicationController
  def index
    @jaunts = Jaunt.all
  end

  def create
    # @google_api_key = Rails.application.secrets.google_api_key
    addresses = params[:jaunt][:addresses].map { |address| Location.new(address: address)}
    Jaunt.create(title: params[:jaunt][:title], locations: addresses)
    redirect_to jaunts_path
  end
end
