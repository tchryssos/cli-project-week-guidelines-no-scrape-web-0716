# require "pry"
# user_weather = [{"id"=>803,
#   "main"=>"Clouds",
#   "description"=>"broken clouds",
#   "icon"=>"04d"},
#  {"temp"=>297.43,
#   "pressure"=>1020,
#   "humidity"=>57,
#   "temp_min"=>294.82,
#   "temp_max"=>299.15}]

class WeatherReport
  @@all=[]

  attr_accessor :city, :weather_hash, :weather_description, :weather_details, :temperature, :humidity, :high_of, :low_of, :wind_speed, :tomorrow_temp, :tomorrow_weather, :day_after_temp, :day_after_weather, :two_days_temp, :two_days_weather

  def initialize(weather_hash)
    @weather_hash = weather_hash
    @weather_description = weather_hash[0]["main"]
    @weather_details = weather_hash[0]["description"]
    @temperature = ((weather_hash[1]["temp"]-273.15)*9/5+32).round
    @humidity=weather_hash[1]["humidity"]
    @high_of = ((weather_hash[1]["temp_max"]-273.15)*9/5+32).round
    @low_of = ((weather_hash[1]["temp_min"]-273.15)*9/5+32).round
    @wind_speed = weather_hash[2]["speed"]
    @tomorrow_weather = weather_hash[4]
    @tomorrow_temp = ((weather_hash[3]-273.15)*9/5+32).round
    @day_after_temp = ((weather_hash[5]-273.15)*9/5+32).round
    @day_after_weather = weather_hash[6]
    @two_days_temp = ((weather_hash[7]-273.15)*9/5+32).round
    @two_days_weather = weather_hash[8]

    @@all<<self
  end

  def print_report
    puts "Current weather condition in #{self.city.tr("_"," ").split.map(&:capitalize).join(" ")}".cyan + ": #{self.weather_description} (#{self.weather_details})"
    puts "The current temperature is #{self.temperature}ºF."
    puts "The temperature will reach a "+"high".red + " of " +"#{self.high_of}ºF".red + " and a " + "low".light_blue + " of "+"#{self.low_of}ºF.".light_blue
    puts "The humidity is #{self.humidity}%."
    puts "The current wind speed is #{self.wind_speed} mph."
    puts
    puts "Tomorrow".yellow+" in #{self.city.tr("_"," ").split.map(&:capitalize).join(" ")}: #{self.tomorrow_weather}, #{self.tomorrow_temp}ºF"
    puts "Two day forecast".yellow+": #{self.day_after_weather}, #{self.day_after_temp}ºF"
    puts "Three day forecast".yellow+": #{self.two_days_weather}, #{self.two_days_temp}ºF"
  end
end
