import 'package:flutter/material.dart';
import 'package:weatherapp/cubit/weathers_cubit.dart';
import 'package:weatherapp/models/weathers_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final weatherCubit = context.bloc<WeathersCubit>();
    // weatherCubit.getCityWeatherDetails();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Weather App"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                weatherCubit.changeStateToInit();
              })
        ],
      ),
      body: Container(
          child: BlocConsumer<WeathersCubit, WeathersState>(
        builder: (context, state) {
          if (state is WeathersInitial || state is WeathersFailure) {
            return initsWidgetState();
          } else if (state is WeathersLoading) {
            print(state);
            return weatherLoading();
          } else if (state is WeathersLoaded) {
            return completedWidget(context, state.weatherDetails);
            // return completedWidget(context, state.weatherDetails);
          }
          print(state);
          return initsWidgetState();
        },
        listener: (context, state) {
          // if(state is )
        },
      )),
    );
  }

  // Widget initialState(BuildContext context) =>
  // WeatherDetails details = WeatherDetails();

  Widget initsWidgetState() {
    final weatherCubit = context.bloc<WeathersCubit>();
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .85,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            color: Colors.white,
            child: TextField(
              onChanged: (String val) =>
                  weatherCubit.weatherRepository.stringController(val),
              controller: weatherCubit.weatherRepository.initialTextName,
              decoration: InputDecoration(
                hintText: "Search for City",
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                weatherCubit.getCityWeatherDetails();
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * .85,
                  height: 55,
                  child: Center(
                    child: Text(
                      "SEARCH",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ))
        ]),
      ),
    );
  }

  Widget completedWidget(BuildContext context, WeatherDetails details) =>
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 20),
                      Center(
                          child: Icon(Icons.location_on, color: Colors.white)),
                      Text(
                        "${details.name}",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 140,
                  child: degreeSymbol(
                      "${details.main.temp}", 10, 5, 5, 7.5, 40, 30, 33),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Text("${details.main.temp_/"),
                    Container(
                        width: 85,
                        height: 40,
                        child: degreeSymbol("${details.main.temp_max}", 10, 5,
                            2, 6, 20, 8, 10.5)),
                    Text(
                      "/",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Container(
                        width: 85,
                        height: 40,
                        child: degreeSymbol("${details.main.temp_min}", 10, 5,
                            5, 7.5, 20, 8, 10.5)),
                    SizedBox(width: 15),

                    Text(
                      "Feels like",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Container(
                        width: 85,
                        height: 40,
                        child: degreeSymbol("${details.main.feels_like}", 10, 5,
                            5, 7.5, 20, 8, 10.5)),

                    // Text("${details.main.temp_min}")
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${details.weather[0].main}",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ]),
        ),
      );

  Widget degreeSymbol(
          String text,
          double firstSquare,
          double secondSquare,
          double right,
          double secondRight,
          double fontSize,
          double top,
          double secondTop) =>
      Stack(
        children: [
          Center(
              child: Text(text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                  ))),
          Positioned(
              top: top,
              right: right,
              child: Container(
                height: firstSquare,
                width: firstSquare,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              )),
          Positioned(
              right: secondRight,
              top: secondTop,
              child: Container(
                height: secondSquare,
                width: secondSquare,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )),
        ],
      );

  Widget weatherLoading() => Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Data Loading",
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ],
      ));
}
