class JauntController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def home
  end

  def index
    @jaunts = Jaunt.all
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
    gon.jaunt = export(Jaunt.find_by_id(params[:id]))
  end

  def destroy
    jaunt = Jaunt.find(params[:id])
    jaunt.destroy
    redirect_to jaunts_path
  end
end
