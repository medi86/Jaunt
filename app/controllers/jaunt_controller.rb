class JauntController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def search
    search = Location.where("address=?", params[:address]).map do |loc|
      loc.jaunts
    end.flatten
    render json: search
  end

  def home
  end

  def index
    gon.jaunts = Jaunt.all
    render "search"
  end

  def new
    gon.jaunt = export(Jaunt.new)
    gon.editPage = false
  end

  def edit
    gon.jaunt = export(Jaunt.find_by_id(params[:id]))
    gon.editPage = true
  end

  def create
    flash[:success] = "New jaunt! Thank you!"
    render json: import(params[:jaunt])
  end

  def show
    @jaunt = Jaunt.find_by_id(params[:id])
    gon.jaunt = export(@jaunt)
  end

  def destroy
    jaunt = Jaunt.find(params[:id])
    jaunt.destroy
    redirect_to jaunts_path
  end
end
