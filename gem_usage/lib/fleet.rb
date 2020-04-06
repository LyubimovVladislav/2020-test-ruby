# frozen_string_literal: true
# Fleet class

class Fleet
  attr_reader :cars

  def initialize
    @cars = []
  end

  def add(new_car)
    @cars.push(new_car)
  end

  def load_from_file(file_name)
    require 'json'
    json_data = File.read(file_name)
    ruby_objects = JSON.parse(json_data)
    ruby_objects.each do |car|
      add(Auto.new(car['mark'], car['model'], car['year'], car['consumption']))
    end
  end

  def int?(str)
    Integer(str) rescue false
  end

  def load_from_stream
    require 'tty-prompt'
    prompt = TTY::Prompt.new
    array = prompt.multiline("describe your car:\nmark: model: year: consumption: ")
    pp array
    array.each do |string|
      a = string.split(" ")
      next if(ar_car.size != 4)
      next unless (year = integer? ar_car[2]) && (benz = integer?ar_car[3])
      add(Car.new(ar_car[0], ar_car[1], year, benz))
    end
  end

  def average_consumption
    whoal_benz = 0
    cars.each do |car|
      whoal_benz += car.benz
    end
    whoal_benz / cars.size
  end

  def number_by_brand(brand)
    whoal_cars_by_brand = 0
    cars.each do |car|
      whoal_cars_by_brand += 1 if car.mark.downcase == brand.downcase
    end
    whoal_cars_by_brand
  end

  def number_by_model(model)
    whoal_cars_by_model = 0
    cars.each do |car|
      whoal_cars_by_model += 1 if car.model.downcase == model.downcase
    end
    whoal_cars_by_model
  end

  def consumption_by_brand(brand)
    whoal_cars_by_brand = 0
    whoal_benz = 0
    cars.each do |car|
      if car.mark.downcase == brand.downcase
        whoal_cars_by_brand += 1
        whoal_benz += car.benz
      end
    end
    return 0 if whoal_cars_by_brand <= 0

    whoal_benz / whoal_cars_by_brand
  end
end
