class JauntController < ApplicationController
  def index
  end

  def new
    @jaunt = Jaunt.new
  end

  def create
    require "pry"
    binding.pry
  end
end
