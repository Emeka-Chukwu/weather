import 'package:flutter/material.dart';
import 'package:weatherapp/cubit/weathers_cubit.dart';
import 'package:weatherapp/page/home_page.dart';
import 'package:weatherapp/repositories/weather_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
          create: (context) => WeathersCubit(WeatherRepository()),
          child: MyHomePage(),
        ));
  }
}
