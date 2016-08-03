require 'pry'
require 'JSON'
require 'rest-client'
require_relative '../models/weather_report.rb'

class WeatherApiCaller

  attr_accessor :city
  attr_reader :current_weather_data, :three_day_forecast, :user_weather, :key1, :key2


  def initialize(city)
    @city = city.tr(" ","_")
    @three_day_forecast=JSON.parse(RestClient.get("http://api.openweathermap.org/data/2.5/forecast/daily?q=#{@city}&APPID=#{key}"))
    @current_weather_data = JSON.parse(RestClient.get("http://api.openweathermap.org/data/2.5/weather?q=#{@city}&APPID=#{key}"))
    @user_weather = []
    store_weather
  end

  def store_weather
     @user_weather << self.current_weather_data["weather"][0]
     @user_weather << self.current_weather_data["main"]
     @user_weather << self.current_weather_data["wind"]
     @user_weather << self.three_day_forecast["list"][1]["temp"]["day"]
     @user_weather << self.three_day_forecast["list"][1]["weather"][0]["main"]
     @user_weather << self.three_day_forecast["list"][2]["temp"]["day"]
     @user_weather << self.three_day_forecast["list"][2]["weather"][0]["main"]
     @user_weather << self.three_day_forecast["list"][3]["temp"]["day"]
     @user_weather << self.three_day_forecast["list"][3]["weather"][0]["main"]
  end


  def create_weather_report
   weather_report=WeatherReport.new(@user_weather)
   weather_report.city=@city
   weather_report
  end
end
