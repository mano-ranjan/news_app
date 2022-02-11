import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/newsdetails_bloc.dart';
import 'package:news_app/home_page.dart';
import 'package:news_app/providers/news_details_providers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NewsDetailsModule()),
      BlocProvider(create: (BuildContext context) => NewsDetailsCounterBloc()),
      // BlocProvider(create: (BuildContext context) => GetNewsDetailsBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
