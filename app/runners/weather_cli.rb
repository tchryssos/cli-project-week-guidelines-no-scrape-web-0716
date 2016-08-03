require 'pry'
require_relative '../data_fetchers/weather_api_caller.rb'
require_relative '../models/weather_report.rb'
require 'colorize'

class WeatherCLI

  def call
    puts "Welcome to Cli's Weather Service.".magenta
    puts "Enter the name of a city to see the current weather and a three day forecast."
    puts "or type "+"'help'".red + " to see other options"
    run
  end

  def get_user_input
    gets.chomp.strip
  end

  def run
    input = get_user_input
    if input == "help"
      help
    elsif input == "exit"
      exit_program
    else
      get_city_weather(input)
    end
    puts "Please enter a city or command: "
    run
  end

  def get_city_weather(city_name)
    puts
    city_api_call=WeatherApiCaller.new(city_name)
    new_weather_report=city_api_call.create_weather_report
    new_weather_report.print_report
    puts
  end

  def help
    puts
    puts "Type a city name to get a weather report for that city"
    puts "Type "+"'help'".red + " to view this menu again"
    puts "Type "+"'exit'".blue + " to exit"
    puts
  end

  def exit_program
    puts
    puts "Thanks for visiting Cli's Weather Service!".magenta
    puts
    puts
    exit
  end
end
