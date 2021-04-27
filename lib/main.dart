import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/data/city.dart';
import 'package:my_app/data/weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App thời tiết',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  var myApiKey = "ff00f06590bf72e3ee0dba8ff1e0ef24";
  var temp;
  var description;
  var humidity;
  var currently;
  var windSpeed;
  var name;
  var weatherIcon;
  var rootassets = 'assets/animated/';
  var isLoading = false;
  CityModel currentCity = cityData[0];
  //
  Future getWeather() async {
            //   print("http://api.openweathermap.org/data/2.5/weather?lat=" +
            // currentCity.lat +
            // "&lon=" +
            // currentCity.lon +
            // "&APPID=ff00f06590bf72e3ee0dba8ff1e0ef24&units=metric&lang=vi");
    Response response = await Dio().get(

        "http://api.openweathermap.org/data/2.5/weather?lat=" +
            currentCity.lat +
            "&lon=" +
            currentCity.lon +
            "&APPID=ff00f06590bf72e3ee0dba8ff1e0ef24&units=metric&lang=vi");
    var result = response.data;

    var _weather = await getWeatherIcon(result['weather'][0]['main']);
    var _weatherIcon;
    if (_weather != null) {
      if (DateTime.now().hour > 18 && DateTime.now().hour < 6) {
        _weatherIcon = rootassets + _weather.nightJsonName;
      } else {
        _weatherIcon = rootassets + _weather.dayJsonName;
      }
      setState(() {
        this.temp = result['main']['temp'];
        this.currently = result['weather'][0]['main'];
        this.description = _weather.description;
        this.humidity = result['main']['humidity'];
        this.windSpeed = result['wind']['speed'];
        this.name = result['name'];
        this.weatherIcon = _weatherIcon;
      });
    }
  }

  Future<WeatherModel> getWeatherIcon(dynamic main) async {
    WeatherModel currentData = weaththerData.where((e) => e.main == main).first;
    if (currentData != null) {
      return currentData;
    }
    return null;
  }

  Widget _buildContent(contetxt, index) {
    currentCity = cityData[index];
    this.getWeather();
    return Column(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    cityData[index].name != null
                        ? cityData[index].name
                        : "loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                // Text(temp != null ? temp.toString() +  "\u00B0" : "30 \u00B0",
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 40.0,
                //         fontWeight: FontWeight.w600)),
                //
                SizedBox(
                    child: Lottie.asset(weatherIcon, width: 100, height: 100)),

                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    description != null ? description : "loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Lottie.asset('assets/icon/temperature.json',
                    width: 40, height: 40),
                title: Text("Nhiệt độ"),
                trailing:
                    Text(temp != null ? temp.toString() + "\u00B0" : "loading"),
              ),
              // ListTile(
              //   leading: FaIcon(FontAwesomeIcons.cloud),
              //   title: Text("Thời tiết"),
              //   trailing: Text(description != null ? description : "loading"),
              // ),
              ListTile(
                leading: Lottie.asset('assets/icon/humidity.json',
                    width: 40, height: 40),
                title: Text("Độ ẩm"),
                trailing: Text(
                    humidity != null ? humidity.toString() + '%' : "loading"),
              ),
              ListTile(
                leading: Lottie.asset('assets/icon/wind.json',
                    width: 40, height: 40),
                title: Text("Tốc độ gió"),
                trailing: Text(windSpeed != null
                    ? windSpeed.toString() + " m/s"
                    : "loading"),
              )
            ],
          ),
        ))
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  Widget build(BuildContext context) {
    // final cloudy = new FlareActor("assets/animated/cloudy.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"idle");
    return Scaffold(
        body: PageView.builder(
            itemCount: cityData.length,
            controller: PageController(keepPage: true),
            itemBuilder: (context, index) => _buildContent(context, index)));
  }
}
