import 'package:flutter/material.dart';
import 'package:mausam/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/animation.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  String city = "London"; // Default city
  String? temp;
  String? hum;
  String? airSpeed;
  String? description;
  String? mainWeather;
  String? icon;

  // Animation controllers for the text and background gradient
  late AnimationController _logoAnimationController;
  late AnimationController _textAnimationController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startApp(city);
    });

    // Setting up the animation controllers
    _logoAnimationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _textAnimationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.8, end: 1.5).animate(
      CurvedAnimation(
          parent: _logoAnimationController, curve: Curves.easeInOut),
    );

    _textAnimation = Tween<double>(begin: 0.8, end: 1.5).animate(
      CurvedAnimation(
          parent: _textAnimationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  void startApp(String city) async {
    try {
      worker instance = worker(location: city);
      await instance.getData();

      if (mounted) {
        setState(() {
          temp = instance.temp;
          hum = instance.humidity;
          airSpeed = instance.air_speed;
          description = instance.description;
          mainWeather = instance.main;
          icon = instance.icon;
        });
      }

      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacementNamed(context, '/home', arguments: {
          "temp_value": temp,
          "hum_value": hum,
          "air_speed_value": airSpeed,
          "des_value": description,
          "main_value": mainWeather,
          "icon_value": icon,
          "city_value": city,
        });
      });
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final search =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    city = search?['searchText'] ?? "London";

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade300],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 150),
            ScaleTransition(
              scale: _logoAnimation,
              child:
            Image.asset(
  "images/weather.png",
  height: 200,
  width: 200,
  errorBuilder: (c, e, s) {
    return Text(
      "IMAGE NOT FOUND",
      style: TextStyle(color: Colors.white, fontSize: 25),
    );
  },
),
            ),
            SizedBox(
              height: 50,
            ),
            AnimatedBuilder(
              animation: _textAnimationController,
              builder: (context, child) {
                if (_textAnimationController.status ==
                    AnimationStatus.completed) {
                  _textAnimationController.forward();
                }
                return Opacity(
                  opacity: _textAnimation.value,
                  child: Column(
                    children: [
                      Text(
                        "Mausam App",
                        style: GoogleFonts.acme(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Made by Gawandeep",
                        style: GoogleFonts.acme(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            SpinKitHourGlass(
              color: Colors.white,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
