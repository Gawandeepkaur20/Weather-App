import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("Home initState()");
  }

  @override
  void dispose() {
    super.dispose();
    print("Home widget disposed");
  }

  // Weather tips by description
  String getWeatherTip(String description) {
    description = description.toLowerCase();
    if (description.contains("hot")) {
      return "It's hot outside! Stay hydrated and wear sunscreen.";
    } else if (description.contains("rain")) {
      return "Rainy weather! Don't forget your umbrella.";
    } else if (description.contains("cold")) {
      return "Cold weather! Dress warmly.";
    } else if (description.contains("wind")) {
      return "Windy day! Stay safe and avoid loose objects.";
    } else if (description.contains("smoke")) {
      return "Smoky air! Avoid outdoor activities if possible.";
    } else {
      return "Have a great day! Stay safe and enjoy the weather.";
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 🌟 SAFELY extract data from arguments
    Map info = ModalRoute.of(context)?.settings.arguments as Map? ?? {};

    String tempRaw = info['temp_value']?.toString() ?? "NA";
    String airRaw = info['air_speed_value']?.toString() ?? "NA";
    String icon = info['icon_value'] ?? "01d";
    String getcity = info['city_value'] ?? "Unknown";
    String hum = info['hum_value']?.toString() ?? "--";
    String des = info['des_value']?.toString() ?? "Weather";

    /// 🌟 FIXED: No substring crash
    String temp;
    String air;

    if (tempRaw == "NA") {
      temp = "NA";
      air = "NA";
    } else {
      double t = double.tryParse(tempRaw) ?? 0.0;
      double a = double.tryParse(airRaw) ?? 0.0;

      temp = t.toStringAsFixed(1); // Example: 33.2
      air = a.toStringAsFixed(1);  // Example: 5.4
    }

    String tip = getWeatherTip(des);

    // Random placeholder city for search hint
    List<String> cityList = [
      "Mumbai", "Delhi", "Chennai", "Sangrur", "Patiala", "London", "Bathinda"
    ];
    String randomCity = cityList[Random().nextInt(cityList.length)];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: GradientAppBar(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue.shade200],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.indigo.shade900,
                  Colors.blue.shade600,
                  Colors.cyan.shade400
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 20),

                //---------------- SEARCH BAR ----------------
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (searchController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Please enter a city name")),
                            );
                            return;
                          }

                          Navigator.pushReplacementNamed(
                            context,
                            "/loading",
                            arguments: {
                              "searchText": searchController.text.trim()
                            },
                          );
                        },
                        child: Icon(Icons.search, color: Colors.blueAccent),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search $randomCity",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                //---------------- WEATHER TITLE ----------------
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white.withOpacity(0.9),
                  ),
                  child: Center(
                    child: Text(
                      "Weather Updates",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                //---------------- MAIN WEATHER CARD ----------------
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                          "http://openweathermap.org/img/wn/$icon@2x.png"),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(des,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade800)),
                          Text("In $getcity",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87)),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                //---------------- TIP BOX ----------------
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.orangeAccent.withOpacity(0.8),
                  ),
                  child: Text(
                    tip,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),

                SizedBox(height: 10),

                //---------------- TEMPERATURE BOX ----------------
                Container(
                  height: 250,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey.shade200],
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(WeatherIcons.thermometer,
                          color: Colors.red, size: 40),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(temp,
                              style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade600)),
                          Text("°C",
                              style: TextStyle(fontSize: 30)),
                        ],
                      )
                    ],
                  ),
                ),

                SizedBox(height: 10),

                //---------------- WIND + HUMIDITY ----------------
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        margin: EdgeInsets.only(left: 20, right: 10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.8),
                        ),
                        child: Column(
                          children: [
                            Icon(WeatherIcons.day_windy,
                                color: Colors.blue.shade600),
                            SizedBox(height: 20),
                            Text(air,
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade900)),
                            Text("km/hr")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 200,
                        margin: EdgeInsets.only(right: 20, left: 10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.8),
                        ),
                        child: Column(
                          children: [
                            Icon(WeatherIcons.humidity,
                                color: Colors.teal.shade600),
                            SizedBox(height: 20),
                            Text(hum,
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal.shade900)),
                            Text("Percent")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),

                //---------------- FOOTER ----------------
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text("Made By Gawandeep",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 15)),
                      Text("Data From OpenWeatherMap.org",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
