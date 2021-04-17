import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

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
  var url = Uri.parse(
      "http://api.openweathermap.org/data/2.5/weather?q=hanoi,vn&APPID=ff00f06590bf72e3ee0dba8ff1e0ef24");
  Future getWeather() async {
    http.Response response = await http.get(url);
    
    var result = jsonDecode(response.body);
    print("code ne" + result['main']['temp']);
    setState(() {
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'];
      this.description = result['weather'][0]['description'];
      this.currently = result['weather']['humidity'];
      this.windSpeed = result['weather']['speed'];
    });

  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  Widget build(BuildContext context) {
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
                      "Hà nội",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(temp != null ? temp + "\u00B0" : "30 \u00B0",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Nhiều mây",
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
                  trailing: Text("30 \u00B0"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text("Thời tiết"),
                  trailing: Text("Nắng"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.sun),
                  title: Text("Độ ẩm"),
                  trailing: Text("12"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text("Tốc độ gió"),
                  trailing: Text("14"),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
