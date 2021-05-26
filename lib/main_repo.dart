import 'package:dio/dio.dart';

import 'data/weather.dart';
import 'main_bloc.dart';

class MainApi {
  var myApiKey = "ff00f06590bf72e3ee0dba8ff1e0ef24";
  var rootassets = 'assets/animated/';
  var isLoading = false;
  Future<MainViewModel> getWeather(MainViewModel _viewModel) async {
    // setState(() {
    //   this.isLoading = true;
    // });
    //   print("http://api.openweathermap.org/data/2.5/weather?lat=" +
    // currentCity.lat +
    // "&lon=" +
    // currentCity.lon +
    // "&APPID=ff00f06590bf72e3ee0dba8ff1e0ef24&units=metric&lang=vi");
    var url = "http://api.openweathermap.org/data/2.5/weather?lat=" +
        _viewModel.city.lat +
        "&lon=" +
        _viewModel.city.lat +
        "&APPID=" +
        myApiKey +
        "&units=metric&lang=vi";
    Response response = await Dio().get(url);
    var result = response.data;
    var _weather = await getWeatherIcon(result['weather'][0]['main']);
    var _weatherIcon;
    if (_weather != null) {
      if (DateTime.now().hour > 18 && DateTime.now().hour < 6) {
        _weatherIcon = rootassets + _weather.nightJsonName;
      } else {
        _weatherIcon = rootassets + _weather.dayJsonName;
      }
      _viewModel.temp = result['main']['temp'];
      _viewModel.currently = result['weather'][0]['main'];
      _viewModel.description = _weather.description;
      _viewModel.humidity = result['main']['humidity'];
      _viewModel.windSpeed = result['wind']['speed'];
      _viewModel.name = result['name'];
      _viewModel.weatherIcon = _weatherIcon;
    }
    return _viewModel;
  }

  Future<WeatherModel> getWeatherIcon(dynamic main) async {
    WeatherModel currentData = weaththerData.where((e) => e.main == main).first;
    if (currentData != null) {
      return currentData;
    }
    return null;
  }
}
