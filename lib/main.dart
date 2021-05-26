import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/data/city.dart';

import 'main_bloc.dart';

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
      home: BlocProvider(creator: (_, __) => MainBLoc(), child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MainBLoc _mainbloc;

  Widget _buildContent(
      contetxt, index, AsyncSnapshot<MainViewModel> snapshoot) {
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
                //
                SizedBox(
                  child: snapshoot.data != null
                      ? Lottie.asset(snapshoot.data.weatherIcon,
                          width: 100, height: 100)
                      : Text(
                          "loading",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 27.0,
                              fontWeight: FontWeight.w600),
                        ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    snapshoot.data != null
                        ? snapshoot.data.description
                        : "loading",
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
                trailing: Text(snapshoot.data != null
                    ? snapshoot.data.temp.toString() + "\u00B0"
                    : "loading"),
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
                trailing: Text(snapshoot.data != null
                    ? snapshoot.data.humidity.toString() + '%'
                    : "loading"),
              ),
              ListTile(
                leading: Lottie.asset('assets/icon/wind.json',
                    width: 40, height: 40),
                title: Text("Tốc độ gió"),
                trailing: Text(snapshoot.data != null
                    ? snapshoot.data.windSpeed.toString() + " m/s"
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
    _mainbloc = BlocProvider.of<MainBLoc>(context);
    _mainbloc.initModel();
    super.initState();
  }

  Widget build(BuildContext context) {
    // final cloudy = new FlareActor("assets/animated/cloudy.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"idle");
    return Scaffold(
        body: PageView.builder(
            itemCount: cityData.length,
            controller: PageController(keepPage: true),
            onPageChanged: (page) {
              _mainbloc.getWeatherByCity(page);
            },
            itemBuilder: (context, index) => StreamBuilder<MainViewModel>(
                stream: _mainbloc.stream,
                builder: (context, snapshoot) =>
                    _buildContent(context, index, snapshoot))));
  }
}
