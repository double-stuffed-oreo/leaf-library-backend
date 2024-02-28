class HerbsController < ApplicationController
  def index
    herbs = Herb.all
    render json: herbs
  end

  def create
    herb = Herb.create(herb_params)
    if herb.valid?
      render json: herb
    else
      render json: herb.errors, status: 422
    end
  end

  def update
    herb = Herb.find(params[:id])
    herb.update(herb_params)
    if herb.valid?
      render json: herb
    else
      render json: herb.errors, status: 422
    end
  end

  private
  def herb_params
    params.require(:herb).permit(:name, :scientific_name, :summary, :benefit, :warning, :image, :user_id)
  end
end
