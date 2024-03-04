class TanksController < ApplicationController

  def index
    @tanks = Tank.all
  end

  def show
    @tank = Tank.find(params[:id])
  end

  def new
    @tank = Tank.new
  end

  def create
    @user = current_user
    @tank = Tank.new(user: @user, liters: 5, nitrate: 0, has_lamp: false)
    @tank.save
    redirect_to tank_path(@tank)
  end

end
