class TanksController < ApplicationController
  before_action :set_tank, only: %i[show feed add_lamp add_plant increase_tank_size new_day]
  before_action :set_user, only: %i[index show]
  before_action :authenticate_user!

  CONFIG = {
    plant_price: 5,
    fish_growth: 1,
    food_nitrate_increase: 1,
    plant_nitrate_decrease: 1,
    lamp_price: 20,
    tank_increase_price: 10,
    tank_increase_liters: 5,
    win_bubble_amount: 20
  }.freeze

  # controller actions

  def index
    @tanks = @user.tanks
    @tanks.each { |tank| tank.destroy if tank.fish.last.alive? == false }
    @tanks = @user.tanks
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
    if spend_bubble(CONFIG[:plant_price]) == 'paid'
      @plant = Plant.new
      @plant.tank = @tank
      @plant.save
    end
    redirect_to tank_path(@tank)
  end

  def add_lamp
    if spend_bubble(CONFIG[:lamp_price]) == 'paid' && @tank.has_lamp == false
      @tank.has_lamp = true
      @tank.save
    end
    redirect_to tank_path(@tank)
  end

  def increase_tank_size
    if spend_bubble(CONFIG[:tank_increase_price]) == 'paid'
      @tank.liters += CONFIG[:tank_increase_liters]
      @tank.save
    end
    redirect_to tank_path(@tank)
  end

  def new_day
    night
    if @tank.fish.last.fed?
      plant_action
      if @tank.nitrate >= @tank.liters
        rip
      elsif fish_quantity > @tank.liters
        rip
      else
        fish_get_hungry
        @tank.has_lamp ? lamp_action : plant_life
        win_bubble(CONFIG[:win_bubble_amount])
      end
      day
      redirect_to tank_path(@tank)
    end
  end

  private

  def set_tank
    @tank = Tank.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def win_bubble(amount)
    set_user
    @user.currency += amount
    @user.save
  end

  def spend_bubble(amount)
    set_tank
    set_user
    if (@user.currency - amount) >= 0
      @user.currency -= amount
      @user.save
      'paid'
    else
      flash[:alert] = "Tu n'as pas assez de bubulles"
    end
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

  def rip
    set_tank
    set_user
    @fish = @tank.fish.last
    @fish.alive = false
    @fish.save
    @user.currency = 0
    @user.save
  end

  def fish_quantity
    set_tank
    @fish_quantity = 0
    @tank.fish.each { |f| @fish_quantity += f.size }
    @fish_quantity
  end

  def fish_get_hungry
    set_tank
    @tank.fish.each do |f|
      f.fed = false
      f.save
    end
  end

  def night
    set_tank
    @tank.night = true
  end

  def day
    set_tank
    @tank.night = false
  end
end
