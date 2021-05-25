List<CityModel> cityData = [
  CityModel(
    name: "Hà Nội",
    lat: "21.027763",
    lon: "105.834160",
  ),
  CityModel(
    name: "Hưng Yên",
    lat: "20.852571",
    lon: "106.016998",
  ),
  CityModel(
    name: "Nam Định",
    lat: "20.434971",
    lon: "106.177681",
  ),
  CityModel(
    name: "Hải Dương",
    lat: "20.937342",
    lon: "106.314552",
  ),
  CityModel(
    name: "Bắc Giang",
    lat: "21.301495",
    lon: "106.629128",
  ),
  CityModel(
    name: "Hà Nam",
    lat: "20.583521",
    lon: "105.922989",
  ),
];

class CityModel {
  final String name;
  final String lat;
  final String lon;
  CityModel({
    this.name,
    this.lat,
    this.lon,
  });
}
