import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'data/city.dart';
import 'main_repo.dart';

class MainBLoc implements Bloc {
  final api = new MainApi();
  ValueStream<MainViewModel> get stream => _controller;
  final _controller = BehaviorSubject<MainViewModel>();

  void initModel() async {
    MainViewModel _viewModel = MainViewModel();
    _viewModel.city = cityData[0];
    _controller.add(await api.getWeather(_viewModel));
  }

  void getWeatherByCity(int index) async {
    MainViewModel _viewModel = MainViewModel();
    _viewModel.city = cityData[index];
    _controller.add(await api.getWeather(_viewModel));
  }

  @override
  void dispose() async {
    await _controller.close();
  }
}

class MainViewModel {
  double temp;
  String description;
  int humidity;
  String currently;
  double windSpeed;
  String name;
  String weatherIcon;
  CityModel city;
  MainViewModel(
      {this.temp,
      this.description,
      this.humidity,
      this.currently,
      this.windSpeed,
      this.name,
      this.weatherIcon,
      this.city});
}
