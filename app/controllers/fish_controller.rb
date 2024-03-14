class FishController < ApplicationController
  def new
    @tank = Tank.find(params[:tank_id])
    @fish = Fish.new
  end

  def create
    @tank = Tank.find(params[:tank_id])
    @fish = Fish.new(fish_params)
    @fish.tank = @tank
      if @fish.save
        redirect_to tank_path(@tank, rules: true)
      else
        render :new, status: :unprocessable_entity
    end
  end

  private

  def fish_params
    params.require(:fish).permit(:name)
  end
end
