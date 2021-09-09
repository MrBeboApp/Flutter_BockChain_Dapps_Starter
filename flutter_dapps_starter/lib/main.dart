import 'package:flutter/material.dart';
import 'package:flutter_dapps_starter/helpers/NameFactory.dart';
import 'package:flutter_dapps_starter/pages/homePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NameFactory>(create: (context)=>NameFactory(),
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Arabic Dapps',
        theme: ThemeData(

          primarySwatch: Colors.teal,
        ),
        home: HomePage(),
      ),
    );
  }
}
