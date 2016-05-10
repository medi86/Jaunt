class JauntController < ApplicationController
  def index
    @jaunts = Jaunt.all
  end

  def create
<<<<<<< HEAD
    Jaunt.create(title: params[:jaunt][:title], locations: [Location.new(address: params[:jaunt][:startAddress]),
                                                            Location.new(address: params[:jaunt][:endAddress])])

    # @google_api_key = Rails.application.secrets.google_api_key
=======
    addresses = params[:jaunt][:addresses].map { |address| Location.new(address: address)}
    Jaunt.create(title: params[:jaunt][:title], locations: addresses)
>>>>>>> 1cf1b03d6d11d09e5f02a0918499c9f894c5c252
    redirect_to jaunts_path
  end
end
