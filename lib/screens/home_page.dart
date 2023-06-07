import 'package:flutter/material.dart';
import 'package:weather_demo/model/weather_response.dart';
import 'package:weather_demo/service/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherResponse? weatherResponse;
  bool loading = false;

  Future fetchWeather() async {
    try {
      loading = true;
      setState(() {});
      weatherResponse = await WeatherService().getWeatherData();
    } catch (e) {
      print('$e');
    }
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                children: [
                  searchBox(),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Text('Temp: ${weatherResponse?.main?.temp ?? 0}'),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Text('Humidity: ${weatherResponse?.main?.humidity ?? 0}'),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 150,
                        width: 150,
                        child: Text('Pressure: ${weatherResponse?.main?.pressure ?? 0}'),
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 150,
                        width: 150,
                        child: Text('Air Speed: ${weatherResponse?.wind?.speed ?? 0}'),
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Data Provided By OpenWeatherMap.org")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget searchBox() {
  return Container(
    //padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20)),
    child: const TextField(
      decoration: InputDecoration(
          border: InputBorder.none,
          //contentPadding: EdgeInsets.all(0),

          prefixIcon: Icon(Icons.search, color: Colors.black54),
          hintText: "Search city",
          fillColor: Colors.black54),
    ),
  );
}
