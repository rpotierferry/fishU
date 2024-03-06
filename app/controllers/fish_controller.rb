class FishController < ApplicationController
  def new
    @tank = Tank.find(params[:tank_id])
    @fish = Fish.new
  end

  def create
    @tank = Tank.find(params[:tank_id])
    @fish = Fish.new(fish_params)
    @fish.tank = @tank
    @fish.save
    redirect_to tank_path(@tank)
  end

  private

  def fish_params
    params.require(:fish).permit(:name)
  end
end
