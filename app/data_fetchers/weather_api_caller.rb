require 'pry'
require 'JSON'
require 'rest-client'
require_relative '../models/weather_report.rb'

class WeatherApiCaller

  attr_accessor :city
  attr_reader :weather_data, :user_weather, :key1, :key2


  def initialize(city)
    @city = city.tr(" ","_")
    @key1="00c1683712154bb4db5a3177a06041b5"
    @key2="7de91a2e7068e6cb448cd01c9430df54"
    @weather_data = JSON.parse(RestClient.get("http://api.openweathermap.org/data/2.5/weather?q=#{@city}&APPID=#{key2}"))
    @user_weather = []
    store_weather
  end

  def store_weather
     @user_weather << self.weather_data["weather"][0]
     @user_weather << self.weather_data["main"]
     @user_weather << self.weather_data["wind"]
   end

   def create_weather_report
     weather_report=WeatherReport.new(@user_weather)
     weather_report.city=@city
     weather_report
   end
end
#
# api=WeatherApiCaller.new("los angeles")
# report=api.create_weather_report
