class TanksController < ApplicationController
  before_action :set_tank_and_user, only: %i[show feed bubble]

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
    f.fed = true
    f.save
    @tank.nitrate += 1
    @tank.save
    end
  end

  def bubble(q)
    @user.currency += q
    @user.save
  end

  def add_plant
    @plant = Plant.new(@tank)
    @plant.save
  end

  def plant_action
    @tank.nitrate -= @tank.plant.coun
    @tank.save
  end

  def add_lamp
    @tank.has_lamp = true
    @tank.plant.each do |p|
    p.life_expectancy = nil
    p.save
    end
    @tank.save
  end

  def increase_tank_size
    @tank.liters += 5
    @tank.save
  end

  def new_day
    plant_action
  end

  private

  def set_tank_and_user
    @tank = Tank.find(params[:id])
    @user = @tank.user
  end

end
