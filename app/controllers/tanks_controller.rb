class TanksController < ApplicationController
  before_action :set_tank, only: %i[show feed]
  def index
    @tanks = Tank.all
  end

  def show
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

  def feed
    @tank.fish.each do |f|
    f.size += 1
    f.save
    @tank.nitrate += 1
    @tank.save
    end
  end

  private

  def set_tank
    @tank = Tank.find(params[:id])
  end
end
