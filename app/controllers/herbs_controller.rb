class HerbsController < ApplicationController
  def index
    herbs = Herb.all
    render json: herbs
  end
end
