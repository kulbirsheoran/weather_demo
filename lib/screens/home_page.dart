import 'package:flutter/material.dart';
import 'package:weather_demo/model/weather_response.dart';
import 'package:weather_demo/service/weather_service.dart';
import 'package:weather_icons/weather_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherResponse? weatherResponse;
  bool loading = false;
  bool error = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    fetchWeather();
    super.initState();
  }

  Future fetchWeather({String city = 'Bhiwani'}) async {
    try {
      error = false;
      loading = true;
      setState(() {});
      weatherResponse = await WeatherService().getWeatherData(
        city: city,
      );
    } catch (e) {
      print('$e');
      error = true;
    }
    loading = false;
    setState(() {});
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: error
              ? Center(
                  child: ElevatedButton(
                    child: const Text('Error'),
                    onPressed: () {
                      error = false;
                      weatherResponse = null;
                      textEditingController.clear();
                      setState(() {});
                    },
                  ),
                )
              : ListView(
                  children: [
                    Column(
                      children: [
                        if (loading)
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        searchBox(),
                        const SizedBox(height: 20),
                        getBox(
                          height: 100,
                         icon: WeatherIcons.day_cloudy,
                          text:
                              '${weatherResponse?.name ?? '-'}, ${weatherResponse?.sys?.country ?? '-'}',
                        ),

                        const SizedBox(height: 20),
                     Image.asset('assets/images/day.png'),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            getBox(icon: WeatherIcons.thermometer,
                              height: 120,
                              width: 100,
                              text:
                              ' ${kelvinToCelsius(weatherResponse?.main?.temp ?? 0).toStringAsFixed(0)}',
                            ),
                            getBox( icon: WeatherIcons.humidity,
                              height: 120,
                              width: 100,
                              text:
                              '${weatherResponse?.main?.humidity ?? 0}',
                            ),
                            getBox(icon: WeatherIcons.day_light_wind,
                              height: 120,
                              width: 100,
                              text:
                                  '${weatherResponse?.wind?.speed ?? 0}',
                            ),
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

  Widget getBox({required double height, required text,required icon, double? width,}) {
    return Container(

      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0,top: 8.0,right: 8.0,bottom: 0.0),
        child: Column(
         // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Icon(icon,color: Colors.white,size: 32,),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white,),
                ),
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: textEditingController,
        onSubmitted: (String value) {
          fetchWeather(city: value);
        },
        decoration: const InputDecoration(
            border: InputBorder.none,
            //contentPadding: EdgeInsets.all(0),

            prefixIcon: Icon(Icons.search, color: Colors.black54),
            hintText: "Search city",
            fillColor: Colors.black54),
      ),
    );
  }
}
