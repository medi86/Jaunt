class JauntController < ApplicationController
  def index
    @jaunts = Jaunt.all
  end

  def create
    Jaunt.create(title: params[:jaunt][:title], locations: [Location.new(address: params[:jaunt][:startAddress]),
                                                            Location.new(address: params[:jaunt][:endAddress])])

    # @google_api_key = Rails.application.secrets.google_api_key
    redirect_to jaunts_path
  end
end
