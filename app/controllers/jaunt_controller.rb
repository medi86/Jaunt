class JauntController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def home
  end

  def index
    @jaunts = Jaunt.search(params)
  end

  def new
    gon.jaunt = export(Jaunt.new)
  end

  def edit
    gon.jaunt = export(Jaunt.find_by_id(params[:id]))
  end

  def create
    flash[:success] = "New jaunt! Thank you!"
    render json: import(params[:jaunt])
  end

  def show
    @jaunt = Jaunt.find_by_id(params[:id])
    gon.jaunt = export(@jaunt)[:addresses]
  end

  def destroy
    jaunt = Jaunt.find(params[:id])
    jaunt.destroy
    redirect_to jaunts_path
  end
end
