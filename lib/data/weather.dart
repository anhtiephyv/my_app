List<WeatherModel> weaththerData = [
  WeatherModel(
      main: "Thunderstorm",
      description: "Mưa có sấm chớp",
      dayJsonName: "day-thunder-rain.json",
      nightJsonName: "night-thunderstorm.json"),
  WeatherModel(
      main: "Drizzle",
      description: "Mưa phùn",
      dayJsonName: "day-light-rain.json",
      nightJsonName: "night-light-rains.json"),
  WeatherModel(
      main: "Rain",
      description: "Mưa nặng hạt",
      dayJsonName: "day-heavy-rain.json",
      nightJsonName: "night-heavy-rain.json"),
  WeatherModel(
      main: "Snow",
      description: "Có tuyết",
      dayJsonName: "day-snow.json",
      nightJsonName: "night-snow.json"),
  WeatherModel(
      main: "Clear",
      description: "Trời quang mây",
      dayJsonName: "day-sunny.json",
      nightJsonName: "night-clear-sky.json"),
  WeatherModel(
      main: "Clouds",
      description: "Trời nhiều mây",
      dayJsonName: "day-sun-cloudy-heavy.json",
      nightJsonName: "night-many-clouds.json")
];

class WeatherModel {
  //final int id;
  final String main;
  final String description;
  // final String icon;
  final String dayJsonName;
  final String nightJsonName;
  WeatherModel({
    this.main,
    this.description,
    this.dayJsonName,
    this.nightJsonName,
  });
}
