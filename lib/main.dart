import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App thời tiết',
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
  var url = Uri.parse(
      "http://api.openweathermap.org/data/2.5/weather?q=hanoi,vn&APPID=ff00f06590bf72e3ee0dba8ff1e0ef24");
  Future getWeather() async {
    // http.Response response = await http.get(url);

    // var result = jsonDecode(response.body);
    Response response = await Dio().get(
        "http://api.openweathermap.org/data/2.5/weather?q=hanoi,vn&APPID=ff00f06590bf72e3ee0dba8ff1e0ef24&units=metric&lang=vi");
    var result = response.data;
    setState(() {
      this.temp = result['main']['temp'];
      this.currently = result['weather'][0]['main'];
      this.description = result['weather'][0]['description'];
      this.humidity = result['main']['humidity'];
      this.windSpeed = result['wind']['speed'];
      this.name = result['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  Widget build(BuildContext context) {
    // final cloudy = new FlareActor("assets/animated/cloudy.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"idle");
    return Scaffold(
      body: Column(
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
                      name,
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
                  SizedBox(child: Lottie.asset('assets/animated/sun-rainy.json', width: 80, height: 80)),
                
                  
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      currently != null ? currently : "loading",
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
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: Text("Nhiệt độ"),
                  trailing: Text(
                      temp != null ? temp.toString() + "\u00B0" : "loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text("Thời tiết"),
                  trailing: Text(description != null ? description : "loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.sun),
                  title: Text("Độ ẩm"),
                  trailing:
                      Text(humidity != null ? humidity.toString() : "loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text("Tốc độ gió"),
                  trailing: Text(
                      windSpeed != null ? windSpeed.toString() : "loading"),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
