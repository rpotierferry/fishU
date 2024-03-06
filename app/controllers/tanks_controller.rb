class TanksController < ApplicationController
  before_action :set_tank, only: %i[show feed add_lamp add_plant increase_tank_size new_day]
  before_action :authenticate_user!

  CONFIG = {
    plant_price: -5,
    fish_growth: 1,
    food_nitrate_increase: 1,
    plant_nitrate_decrease: 1,
    lamp_price: -20,
    tank_increase_price: -10,
    tank_increase_liters: 5,
    win_bubble_amount: 20
  }.freeze

  # controller actions

  def index
    @tanks = Tank.all
  end

  def show; end

  def new
    @tank = Tank.new
  end

  def create
    @user = current_user
    @tank = Tank.new
    @tank.user = @user
    @tank.save
    redirect_to tank_path(@tank)
  end

  # user actions

  def feed
    @tank.fish.each do |f|
      f.size += CONFIG[:fish_growth]
      f.fed = true
      f.save
      @tank.nitrate += CONFIG[:food_nitrate_increase]
    end
    @tank.save
    redirect_to tank_path(@tank)
  end

  def add_plant
    @plant = Plant.new
    @plant.tank = @tank
    @plant.save
    redirect_to tank_path(@tank)
    bubble(CONFIG[:plant_price])
  end

  def add_lamp
    @tank.has_lamp = true
    @tank.save
    redirect_to tank_path(@tank)
    bubble(CONFIG[:lamp_price])
  end

  def increase_tank_size
    @tank.liters += CONFIG[:tank_increase_liters]
    @tank.save
    bubble(CONFIG[:tank_increase_price])
    redirect_to tank_path(@tank)
  end

  def new_day
    plant_action
    raise if @tank.nitrate >= @tank.liters

    @tank.fish.each do |f|
      f.fed = false
      f.save
    end
    @tank.has_lamp ? lamp_action : plant_life
    bubble(CONFIG[:win_bubble_amount])
    redirect_to tank_path(@tank)
  end

  private

  def set_tank
    @tank = Tank.find(params[:id])
  end

  def bubble(amount)
    set_tank
    @user = @tank.user
    @user.currency += amount
    @user.save
  end

  def plant_action
    set_tank
    @tank.nitrate -= (@tank.plants.count * CONFIG[:plant_nitrate_decrease])
    @tank.save
  end

  def lamp_action
    set_tank
    @tank.plants.each do |p|
      p.life_expectancy = nil
      p.save
    end
  end

  def plant_life
    set_tank
    @tank.plants.each do |p|
      p.life_expectancy.zero? ? p.destroy : p.life_expectancy -= 1
      p.save
    end
  end
end
