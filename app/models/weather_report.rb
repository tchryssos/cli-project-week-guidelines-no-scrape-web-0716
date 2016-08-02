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

  attr_accessor :city, :weather_hash, :weather_description, :weather_details, :temperature, :humidity, :high_of, :low_of, :wind_speed

  def initialize(weather_hash)
    @weather_hash = weather_hash
    @weather_description = weather_hash[0]["main"]
    @weather_details = weather_hash[0]["description"]
    @temperature = ((weather_hash[1]["temp"]-273.15)*9/5+32).round
    @humidity=weather_hash[1]["humidity"]
    @high_of = ((weather_hash[1]["temp_max"]-273.15)*9/5+32).round
    @low_of = ((weather_hash[1]["temp_min"]-273.15)*9/5+32).round
    @wind_speed = weather_hash[2]["speed"]
    @@all<<self
  end

  def print_report
    puts "Current weather condition in #{self.city.tr("_"," ").split.map(&:capitalize).join(" ")}: #{self.weather_description} (#{self.weather_details})"
    puts "The current temperature is #{self.temperature}ºF."
    puts "The temperature will reach a high of #{self.high_of}ºF and a low of #{self.low_of}ºF."
    puts "The humidity is #{self.humidity}%."
    puts "The current wind speed is #{self.wind_speed} mph."
  end
end
