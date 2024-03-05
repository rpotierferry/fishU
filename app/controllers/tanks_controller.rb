class TanksController < ApplicationController
  before_action :set_tank

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
    @tank = Tank.new(@user)
    @tank.save
    redirect_to tank_path(@tank)
  end

  def feed
    @tank.fish.each do |f|
    f.size += 1
    f.fed = true
    f.save
    @tank.nitrate += 1
    end
    @tank.save
    redirect_to tank_path(@tank)
  end

  def bubble(q)
    @user = @tank.user
    @user.currency += q
    @user.save
  end

  def add_plant
    @plant = Plant.new
    @plant.tank = @tank
    @plant.save
    redirect_to tank_path(@tank)
  end

  def plant_action
    @tank.nitrate -= @tank.plants.count
    @tank.save
  end

  def add_lamp
    @tank.has_lamp = true
    @tank.plants.each do |p|
    p.life_expectancy = nil
    p.save
    end
    @tank.save
    redirect_to tank_path(@tank)
  end

  def increase_tank_size
    @tank.liters += 5
    @tank.save
    redirect_to tank_path(@tank)
  end

  def new_day
    plant_action
    if @tank.nitrate >= @tank.liters
      puts "fishU"
    else @tank.fish.each do |f|
      f.fed = false
      f.save
    end
  end
  redirect_to tank_path(@tank)
  end

  private

  def set_tank
    @tank = Tank.find(params[:id])
  end
end
